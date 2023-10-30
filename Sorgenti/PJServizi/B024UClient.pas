unit B024UClient;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Samples.Spin,
  B024UADSCatanzaroIntf,
  FunzioniGenerali,
  C180FunzioniGenerali,
  System.IOUtils,
  System.SyncObjs,
  System.StrUtils,
  System.Diagnostics,
  System.TimeSpan,
  Winapi.ActiveX, System.IniFiles, IdBaseComponent, IdComponent,
  IdSoapComponent, IdSoapITIProvider, IdSoapClient, IdSoapClientHTTP;

type
  TResCtrl = record
    Ok: Boolean;
    Msg: String;
  end;

  TB024FClient = class(TForm)
    grpInfo: TGroupBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Memo1: TMemo;
    memOutput: TMemo;
    ProgressBar1: TProgressBar;
    Panel1: TPanel;
    grp02GetListaRuoli: TGroupBox;
    Label1: TLabel;
    edt00CodiceComponente: TEdit;
    rgpTipoRichiesta: TRadioGroup;
    Panel2: TPanel;
    Label9: TLabel;
    SpinEdit1: TSpinEdit;
    grp00GetListaApplicativiUtente: TGroupBox;
    Label7: TLabel;
    Label11: TLabel;
    edt02CodiceAmministrazione: TEdit;
    edt02IdentificativoUtente: TEdit;
    grp01GetListaUnita: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    edt03CodiceAmministrazione: TEdit;
    edt03CodiceRuolo: TEdit;
    grp03GetAbilitazioniSoggetto: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edt01CodiceFiscale: TEdit;
    edt01CodiceAmministrazione: TEdit;
    edt01CodiceComponente: TEdit;
    edt01CodiceSistema: TEdit;
    grp04SetAbilitazioniSoggetto: TGroupBox;
    Label6: TLabel;
    edt04CodiceFiscale: TEdit;
    Label14: TLabel;
    edt04Cognome: TEdit;
    edt04Nome: TEdit;
    Label15: TLabel;
    edt04Email: TEdit;
    edt04Telefono: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    edt04CodiceAmministrazione: TEdit;
    Label19: TLabel;
    edt04CodiceComponente: TEdit;
    Label20: TLabel;
    edt04CodiceRuolo: TEdit;
    Label21: TLabel;
    edt04CodiceSistema: TEdit;
    edt04CodiceUnita: TEdit;
    edt04CodiceTipoAutorizzazione: TEdit;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    edt04DataDecorrenzaORevoca: TEdit;
    grp05ModificaAnagrafica: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    edt05CodiceFiscaleOld: TEdit;
    edt05CognomeOld: TEdit;
    edt05NomeOld: TEdit;
    edt05EmailOld: TEdit;
    edt05TelefonoOld: TEdit;
    edt05CodiceFiscaleNew: TEdit;
    edt05CognomeNew: TEdit;
    edt05NomeNew: TEdit;
    edt05EmailNew: TEdit;
    edt05TelefonoNew: TEdit;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    tabInfoServer: TTabSheet;
    TabSheet6: TTabSheet;
    lblHome: TLabel;
    edtHome: TEdit;
    edtPathLog: TEdit;
    Label10: TLabel;
    edtLogonDB: TEdit;
    Label8: TLabel;
    lblWebSvc: TLabel;
    edtUrlWebSvc: TEdit;
    Button1: TButton;
    IdSoapClientHTTP1: TIdSoapClientHTTP;
    procedure FormCreate(Sender: TObject);
    procedure rgpTipoRichiestaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FIntf: IProfilazioneUtente;
    FLogFile: string;
    FOutputStr: string;
    FFileConfigPath: String;
    FFileServerConfigPath: String;
    procedure GetParametri;
    procedure PutParametri;
    procedure LoadLog; inline;
    function DoGetAbilitazioniSoggetto: TResCtrl;
    function DoGetListaApplicativiUtente: TResCtrl;
    function DoGetListaRuoli: TResCtrl;
    function DoGetListaUnita: TResCtrl;
    function DoModificaAnagrafica: TResCtrl;
    function DoSetAbilitazioniSoggetto: TResCtrl;
  public
    { Public declarations }
  end;

const
  ORA_FMT = 'dd/mm/yyyy hh.nn.ss';

  METHODS: array[0..5]  of String = (
    'getListaApplicativiUtente',
    'getListaUnita',
    'getListaRuoli',
    'getAbilitazioniSoggetto',
    'setAbilitazioniSoggetto',
    'modificaAnagrafica'
  );

  OUTPUT_SEPARATOR = '------------------------------------------------------------------------------------------'#13#10;

var
  B024FClient: TB024FClient;

implementation

uses
  B024UADSCatanzaroImpl,
  B024UADSCatanzaroDM;

{$R *.dfm}

procedure TB024FClient.FormCreate(Sender: TObject);
var
  i: Integer;
  LInstallPath: String;
begin
  FIntF:=(IdSoapClientHTTP1 as IProfilazioneUtente);

  LInstallPath:=TPath.GetDirectoryName(GetModuleName(HInstance));
  FFileConfigPath:=TPath.Combine(LInstallPath,B024_CLIENT_INI);
  FFileServerConfigPath:=TPath.Combine(LInstallPath,B024_SERVER_INI);

  // metodi disponibili
  rgpTipoRichiesta.Items.BeginUpdate;
  rgpTipoRichiesta.Items.Clear;
  for i:=Low(METHODS) to High(METHODS) do
    rgpTipoRichiesta.Items.Add(METHODS[i]);
  rgpTipoRichiesta.Items.EndUpdate;

  // nasconde groupbox parametri e imposta l'allineamento
  grp00GetListaApplicativiUtente.Visible:=False;
  grp00GetListaApplicativiUtente.Align:=alClient;
  grp01GetListaUnita.Visible:=False;
  grp01GetListaUnita.Align:=alClient;
  grp02GetListaRuoli.Visible:=False;
  grp02GetListaRuoli.Align:=alClient;
  grp03GetAbilitazioniSoggetto.Visible:=False;
  grp03GetAbilitazioniSoggetto.Align:=alClient;
  grp04SetAbilitazioniSoggetto.Visible:=False;
  grp04SetAbilitazioniSoggetto.Align:=alClient;
  grp05ModificaAnagrafica.Visible:=False;
  grp05ModificaAnagrafica.Align:=alClient;

  // imposta parametri salvati
  GetParametri;

  IdSoapClientHTTP1.SoapURL:=GConfig.ServerURL + '/soap/';

  rgpTipoRichiestaClick(nil);

  // informazioni ambiente
  // 1. url del server
  edtUrlWebSvc.Text:=GConfig.ServerURL;
  // 2. informazioni path
  edtHome.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'','HOME','');
  edtPathLog.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'','PATH_LOG','');
  // 3. impostazioni server
  edtLogonDb.Text:=GConfig.Database;

  // visualizza log preesistente
  FLogFile:=TPath.Combine(edtPathLog.Text,'B024.server.csl');
  LoadLog;

   // seleziona il primo tab
  PageControl1.ActivePageIndex:=0;
end;

procedure TB024FClient.LoadLog;
begin
  if TFile.Exists(FLogFile) then
    Memo1.Lines.LoadFromFile(FLogFile);
end;

procedure TB024FClient.GetParametri;
var
  LIniFile: TIniFile;
  i, j: Integer;
  LGrp: TGroupBox;
  LEdt: TEdit;
begin
  // estrae parametri da file di configurazione
  LIniFile:=TIniFile.Create(FFileConfigPath);
  try
    // impostazioni
    rgpTipoRichiesta.ItemIndex:=LIniFile.ReadInteger(B024_CLIENT_INI_SEZIONE_VALORI,rgpTipoRichiesta.Name,0);

    // ciclo sugli edit nei groupbox
    for i:=0 to Panel1.ControlCount - 1 do
    begin
      if Panel1.Controls[i] is TGroupBox then
      begin
        LGrp:=TGroupBox(Panel1.Controls[i]);
        for j:=0 to LGrp.ControlCount - 1 do
        begin
          if LGrp.Controls[j] is TEdit then
          begin
            LEdt:=TEdit(LGrp.Controls[j]);
            LEdt.Text:=LIniFile.ReadString(B024_CLIENT_INI_SEZIONE_VALORI,LEdt.Name,'');
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(LIniFile);
  end;
end;

procedure TB024FClient.PutParametri;
var
  LIniFile: TIniFile;
  i, j: Integer;
  LGrp: TGroupBox;
  LEdt: TEdit;
begin
  // estrae parametri da file di configurazione
  LIniFile:=TIniFile.Create(FFileConfigPath);
  try
    // impostazioni
    LIniFile.WriteInteger(B024_CLIENT_INI_SEZIONE_VALORI,rgpTipoRichiesta.Name,rgpTipoRichiesta.ItemIndex);

    // ciclo sugli edit nei groupbox
    for i:=0 to Panel1.ControlCount - 1 do
    begin
      if Panel1.Controls[i] is TGroupBox then
      begin
        LGrp:=TGroupBox(Panel1.Controls[i]);
        for j:=0 to LGrp.ControlCount - 1 do
        begin
          if LGrp.Controls[j] is TEdit then
          begin
            LEdt:=TEdit(LGrp.Controls[j]);
            LIniFile.WriteString(B024_CLIENT_INI_SEZIONE_VALORI,LEdt.Name,LEdt.Text);
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(LIniFile);
  end;
end;

procedure TB024FClient.Button1Click(Sender: TObject);
// elaborazione richiesta
var
  i: Integer;
  LStopWatch: TStopwatch;
  LElapsed: TTimeSpan;
  LThreadsNum: Integer;
  LResCtrl: TResCtrl;
  LOutput: string;
begin
  Screen.Cursor:=crHourGlass;
  PutParametri;

  FOutputStr:='';
  LThreadsNum:=SpinEdit1.Value;

  // imposta progressbar
  ProgressBar1.Visible:=(LThreadsNum > 1);
  ProgressBar1.Min:=0;
  ProgressBar1.Max:=LThreadsNum;
  ProgressBar1.Position:=0;
  ProgressBar1.Repaint;

  try
    // elaborazione principale
    for i:=0 to LThreadsNum - 1 do
    begin
      LStopWatch:=TStopwatch.StartNew;

      TThread.Sleep(300);

      CoInitialize(nil);
      try
        case rgpTipoRichiesta.ItemIndex of
          0: LResCtrl:=DoGetListaApplicativiUtente;
          1: LResCtrl:=DoGetListaUnita;
          2: LResCtrl:=DoGetListaRuoli;
          3: LResCtrl:=DoGetAbilitazioniSoggetto;
          4: LResCtrl:=DoSetAbilitazioniSoggetto;
          5: LResCtrl:=DoModificaAnagrafica;
        end;
      finally
        CoUninitialize;
      end;

      LElapsed:=LStopWatch.Elapsed;
      LOutput:=OUTPUT_SEPARATOR +
               Format('#%d: %s [%s | %d ms]'#13#10,[i + 1,rgpTipoRichiesta.Items[rgpTipoRichiesta.ItemIndex],IfThen(LResCtrl.Ok,'ok','err'),LElapsed.Milliseconds]) +
               OUTPUT_SEPARATOR +
               Format('%s',[LResCtrl.Msg]) +
               OUTPUT_SEPARATOR;
      FOutputStr:=FOutputStr + LOutput + #13#10;

      ProgressBar1.StepIt;
      //ProgressBar1.Repaint;
      Application.ProcessMessages;
    end;
  finally
    // fine elaborazione
    memOutput.Lines.Text:=FOutputStr;
    LoadLog;
    ProgressBar1.Visible:=False;
    Screen.Cursor:=crDefault;
    Application.ProcessMessages;

    if (LThreadsNum = 1) and (not LResCtrl.Ok) then
      ShowMessage(LResCtrl.Msg);
  end;
end;

procedure TB024FClient.rgpTipoRichiestaClick(Sender: TObject);
begin
  // nasconde groupbox parametri
  grp00GetListaApplicativiUtente.Visible:=False;
  grp01GetListaUnita.Visible:=False;
  grp02GetListaRuoli.Visible:=False;
  grp03GetAbilitazioniSoggetto.Visible:=False;
  grp04SetAbilitazioniSoggetto.Visible:=False;
  grp05ModificaAnagrafica.Visible:=False;

  // visualizza groupbox parametri selezionato
  case rgpTipoRichiesta.ItemIndex of
    0: grp00GetListaApplicativiUtente.Visible:=True;
    1: grp01GetListaUnita.Visible:=True;
    2: grp02GetListaRuoli.Visible:=True;
    3: grp03GetAbilitazioniSoggetto.Visible:=True;
    4: grp04SetAbilitazioniSoggetto.Visible:=True;
    5: grp05ModificaAnagrafica.Visible:=True;
  end;
end;

function TB024FClient.DoGetListaRuoli: TResCtrl;
var
  LParam: listaRuoliRequest;
  LOutput: listaRuoliResponseArray;
  LOutElem: listaRuoliResponse;
  i: Integer;
const
  NOME_METODO = 'TB024FClient.DoGetListaRuoli';
begin
  Result.Ok:=False;
  Result.Msg:='';

  TLogger.EnterMethod(NOME_METODO);
  try
    LParam:=listaRuoliRequest.Create;
    try
      // imposta parametri chiamata
      LParam.codiceComponente:=edt00CodiceComponente.Text;

      // esegue metodo
      try
        FIntf.getListaRuoli(LParam, LOutput);
      except
        on E: Exception do
        begin
          TLogger.Error('IProfilazioneUtente.getListaRuoli: errore di esecuzione',E);
          Result.Msg:=Format('%s (%s)',[E.Message,E.ClassName]);
          Exit;
        end;
      end;

      // visualizza a video il risultato
      Result.Ok:=True;
      Result.Msg:=Format('%d record'#13#10,[Length(LOutput)]);
      for i:=Low(LOutput) to High(LOutput) do
      begin
        LOutElem:=LOutput[i];
        Result.Msg:=Result.Msg + #13#10 +
          Format('[%.3d]'#13#10,[i]) +
          Format('  |_ [codiceRuolo]              = %s'#13#10,[LOutElem.codiceRuolo]) +
          Format('  |_ [descrizioneRuolo]         = %s'#13#10,[LOutElem.descrizioneRuolo]) +
          Format('  |_ [areeAccessibili]          = %s'#13#10,[LOutElem.areeAccessibili]);
      end;
    finally
      LParam.Free;
      SetLength(LOutput,0);
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

function TB024FClient.DoGetAbilitazioniSoggetto: TResCtrl;
var
  LParam: abilitazioniSoggettoGetRequest;
  LOutput: abilitazioniSoggettoGetResponseArray;
  LOutElem: abilitazioniSoggettoGetResponse;
  i: Integer;
const
  NOME_METODO = 'TB024FClient.DoGetAbilitazioniSoggetto';
begin
  Result.Ok:=False;
  Result.Msg:='';

  TLogger.EnterMethod(NOME_METODO);
  try
    LParam:=abilitazioniSoggettoGetRequest.Create;
    try
      // imposta parametri chiamata
      LParam.codiceSistema:=edt01CodiceSistema.Text;
      LParam.codiceAmministrazione:=edt01CodiceAmministrazione.Text;
      LParam.codiceComponente:=edt01CodiceComponente.Text;
      LParam.codFiscaleSoggettoDaAbilitare:=edt01CodiceFiscale.Text;

      // esegue metodo
      try
        FIntf.getAbilitazioniSoggetto(LParam,LOutput);
      except
        on E: Exception do
        begin
          TLogger.Error('IProfilazioneUtente.getAbilitazioniSoggetto: errore di esecuzione',E);
          Result.Msg:=Format('%s (%s)',[E.Message,E.ClassName]);
          Exit;
        end;
      end;

      // visualizza a video il risultato
      Result.Ok:=True;
      Result.Msg:=Format('%d record'#13#10,[Length(LOutput)]);
      for i:=Low(LOutput) to High(LOutput) do
      begin
        LOutElem:=LOutput[i];
        Result.Msg:=Result.Msg + #13#10 +
          Format('[%.3d]'#13#10,[i]) +
          Format('  |_ [codiceRuolo]              = %s'#13#10,[LOutElem.codiceRuolo]) +
          Format('  |_ [descrizioneRuolo]         = %s'#13#10,[LOutElem.descrizioneRuolo]) +
          Format('  |_ [codiceTipoAutorizzazione] = %d'#13#10,[LOutElem.codiceTipoAutorizzazione]) +
          Format('  |_ [codiceUnita]              = %s'#13#10,[LOutElem.codiceUnita]) +
          Format('  |_ [descrizioneUnita]         = %s'#13#10,[LOutElem.descrizioneUnita]) +
          Format('  |_ [dataDecorrenza]           = %s'#13#10,[DateToStr(LOutElem.dataDecorrenza.AsDateTime)]) +
          Format('  |_ [dataScadenza]             = %s'#13#10,[DateToStr(LOutElem.dataScadenza.AsDateTime)]);
      end;
    finally
      LParam.Free;
      SetLength(LOutput,0);
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

function TB024FClient.DoGetListaApplicativiUtente: TResCtrl;
var
  LParam: listaApplicativiUtenteGetRequest;
  LOutput: listaApplicativiUtenteGetResponseArray;
  LOutElem: listaApplicativiUtenteGetResponse;
  i: Integer;
const
  NOME_METODO = 'TB024FClient.DoGetListaApplicativiUtente';
begin
  Result.Ok:=False;
  Result.Msg:='';

  TLogger.EnterMethod(NOME_METODO);
  try
    LParam:=listaApplicativiUtenteGetRequest.Create;
    try
      // imposta parametri chiamata
      LParam.codiceAmministrazione:=edt02CodiceAmministrazione.Text;
      LParam.identificativoUtente:=edt02IdentificativoUtente.Text;

      // esegue metodo
      try
        LOutput:=FIntf.getListaApplicativiUtente(LParam);
      except
        on E: Exception do
        begin
          TLogger.Error('IProfilazioneUtente.getListaApplicativiUtente: errore di esecuzione',E);
          Result.Msg:=Format('%s (%s)',[E.Message,E.ClassName]);
          Exit;
        end;
      end;

      // visualizza a video il risultato
      Result.Ok:=True;
      Result.Msg:=Format('%d record'#13#10,[Length(LOutput)]);
      for i:=Low(LOutput) to High(LOutput) do
      begin
        LOutElem:=LOutput[i];
        Result.Msg:=Result.Msg + #13#10 +
          Format('[%.3d]'#13#10,[i]) +
          Format('  |_ [codice]              = %s'#13#10,[LOutElem.codice]) +
          Format('  |_ [descrizione]         = %s'#13#10,[LOutElem.descrizione]) +
          Format('  |_ [url]                 = %s'#13#10,[LOutElem.url]);
      end;
    finally
      LParam.Free;
      SetLength(LOutput,0);
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

function TB024FClient.DoGetListaUnita: TResCtrl;
var
  LParam: listaUnitaRequest;
  LOutput: listaUnitaResponseArray;
  LOutElem: listaUnitaResponse;
  i: Integer;
const
  NOME_METODO = 'TB024FClient.DoGetListaUnita';
begin
  Result.Ok:=False;
  Result.Msg:='';

  TLogger.EnterMethod(NOME_METODO);
  try
    LParam:=listaUnitaRequest.Create;
    try
      // imposta parametri chiamata
      LParam.codiceAmministrazione:=edt03CodiceAmministrazione.Text;
      LParam.codiceRuolo:=edt03CodiceRuolo.Text;

      // esegue metodo
      try
        FIntf.getListaUnita(LParam,LOutput);
      except
        on E: Exception do
        begin
          TLogger.Error('IProfilazioneUtente.getListaUnita: errore di esecuzione',E);
          Result.Msg:=Format('%s (%s)',[E.Message,E.ClassName]);
          Exit;
        end;
      end;

      // visualizza a video il risultato
      Result.Ok:=True;
      Result.Msg:=Format('%d record'#13#10,[Length(LOutput)]);
      for i:=Low(LOutput) to High(LOutput) do
      begin
        LOutElem:=LOutput[i];
        Result.Msg:=Result.Msg + #13#10 +
          Format('[%.3d]'#13#10,[i]) +
          Format('  |_ [codiceUnita]              = %s'#13#10,[LOutElem.codiceUnita]) +
          Format('  |_ [descrizioneUnita]         = %s'#13#10,[LOutElem.descrizioneUnita]);
      end;
    finally
      LParam.Free;
      SetLength(LOutput,0);
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

function TB024FClient.DoSetAbilitazioniSoggetto: TResCtrl;
var
  LParam: abilitazioniSoggettoSetRequest;
const
  NOME_METODO = 'TB024FClient.DoSetAbilitazioniSoggetto';
begin
  Result.Ok:=False;
  Result.Msg:='';

  TLogger.EnterMethod(NOME_METODO);
  try
    LParam:=abilitazioniSoggettoSetRequest.Create;
    try
      // imposta parametri chiamata
      LParam.codiceFiscale:=edt04CodiceFiscale.Text;
      LParam.cognome:=edt04Cognome.Text;
      LParam.nome:=edt04Nome.Text;
      LParam.email:=edt04Email.Text;
      LParam.profilo:=profiloRequest.Create;
      LParam.profilo.codiceAmministrazione:=edt04CodiceAmministrazione.Text;
      LParam.profilo.codiceComponente:=edt04CodiceComponente.Text;
      LParam.profilo.codiceRuolo:=edt04CodiceRuolo.Text;
      LParam.profilo.codiceSistema:=edt04CodiceSistema.Text;
      LParam.profilo.codiceTipoAutorizzazione:=StrtoInt(edt04CodiceTipoAutorizzazione.Text);
      LParam.profilo.codiceUnita:=edt04CodiceUnita.Text;
      LParam.profilo.dataDecorrenzaORevoca:=edt04DataDecorrenzaORevoca.Text;
      LParam.telefono:=edt04Telefono.Text;

      // esegue metodo
      try
        FIntf.setAbilitazioniSoggetto(LParam);
      except
        on E: Exception do
        begin
          TLogger.Error('IProfilazioneUtente.setAbilitazioniSoggetto: errore di esecuzione',E);
          Result.Msg:=Format('%s (%s)',[E.Message,E.ClassName]);
          Exit;
        end;
      end;

      // visualizza a video il risultato
      Result.Ok:=True;
      Result.Msg:='modifica ok';
    finally
      LParam.Free;
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

function TB024FClient.DoModificaAnagrafica: TResCtrl;
var
  LOldSoggetto: WSSoggetto;
  LNewSoggetto: WSSoggetto;
const
  NOME_METODO = 'TB024FClient.DoModificaAnagrafica';
begin
  Result.Ok:=False;
  Result.Msg:='';

  TLogger.EnterMethod(NOME_METODO);
  try
    LOldSoggetto:=WSSoggetto.Create;
    LNewSoggetto:=WSSoggetto.Create;
    try
      // imposta parametri chiamata
      LOldSoggetto.codiceFiscale:=edt05CodiceFiscaleOld.Text;
      LOldSoggetto.cognome:=edt05CognomeOld.Text;
      LOldSoggetto.nome:=edt05NomeOld.Text;
      LOldSoggetto.email:=edt05EmailOld.Text;
      LOldSoggetto.telefono:=edt05TelefonoOld.Text;

      LNewSoggetto.codiceFiscale:=edt05CodiceFiscaleNew.Text;
      LNewSoggetto.cognome:=edt05CognomeNew.Text;
      LNewSoggetto.nome:=edt05NomeNew.Text;
      LNewSoggetto.email:=edt05EmailNew.Text;
      LNewSoggetto.telefono:=edt05TelefonoNew.Text;

      // esegue metodo
      try
        FIntf.modificaAnagrafica(LOldSoggetto,LNewSoggetto);
      except
        on E: Exception do
        begin
          TLogger.Error('IProfilazioneUtente.modificaAnagrafica: errore di esecuzione',E);
          Result.Msg:=Format('%s (%s)',[E.Message,E.ClassName]);
          Exit;
        end;
      end;

      // visualizza a video il risultato
      Result.Ok:=True;
      Result.Msg:='modifica ok';
    finally
      LOldSoggetto.Free;
      LNewSoggetto.Free;
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

initialization
  TLogger.Configure(TLogOptions.Create('client di test B024',True,True,R180GetPathLog,'B024.client.csl'));

end.
