unit B110UForm;

interface

uses
  B110UUtils,
  FunzioniGenerali,
  IdSchedulerOfThreadPool, System.IOUtils,
  B110UServerMethodsDM, C180FunzioniGenerali, A000UCostanti,
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp,
  System.Win.TaskbarCore, Vcl.Taskbar, Vcl.WinXCtrls, System.UITypes;

type
  TB110FForm = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    EditPort: TEdit;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    ButtonOpenBrowser: TButton;
    btnRunClient: TButton;
    memParametriServer: TMemo;
    Label2: TLabel;
    Taskbar1: TTaskbar;
    swcLiveView: TToggleSwitch;
    lblLiveView: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);
    procedure btnRunClientClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure swcLiveViewClick(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    FClientPath: String;
    procedure StartServer;
  end;

var
  B110FForm: TB110FForm;

const
  B110_TEST_CLIENT = 'AM000PIrisApp.exe';

implementation

{$R *.dfm}

uses
  WinApi.Windows,
  Winapi.ShellApi,
  Datasnap.DSSession,
  C200UWebServicesServerUtils;

procedure TB110FForm.FormShow(Sender: TObject);
begin
  EditPort.Text:=TB110FParametriServer.Impostazioni_Port.ToString;

  // parametri di configurazione
  memParametriServer.Lines.Text:=TB110FParametriServer.ToString;

  // determina posizione client di test
  FClientPath:=TPath.Combine(TPath.GetDirectoryName(GetModuleName(HInstance)),B110_TEST_CLIENT);
  btnRunClient.Enabled:=TFile.Exists(FClientPath);

  // stato liveview
  if TB110FParametriServer.Impostazioni_LiveViewLog then
    swcLiveView.State:=tssOn
  else
    swcLiveView.State:=tssOff;
end;

procedure TB110FForm.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
  ShowMessage(E.Message);
end;

procedure TB110FForm.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
  EditPort.Enabled := not FServer.Active;
  if FServer.Active then
    Taskbar1.ProgressState:=TTaskBarProgressState.Normal
  else
    Taskbar1.ProgressState:=TTaskBarProgressState.None;
end;

procedure TB110FForm.btnRunClientClick(Sender: TObject);
begin
  // esegue client
  if TFile.Exists(FClientPath) then
    ShellExecute(0,'open',PChar(FClientPath),'',nil,SW_SHOWNORMAL);
end;

procedure TB110FForm.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%s', [EditPort.Text]);
  ShellExecute(0,
        nil,
        PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TB110FForm.ButtonStartClick(Sender: TObject);
begin
  StartServer;
end;

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

procedure TB110FForm.ButtonStopClick(Sender: TObject);
begin
  TerminateThreads;
  FServer.Active := False;
  FServer.Bindings.Clear;
  TLogger.Debug('Form StopServer');
end;

procedure TB110FForm.FormCreate(Sender: TObject);
var
  SchedulerOfThreadPool: TIdSchedulerOfThreadPool;
const
  NOME_METODO = 'TB110FForm.FormCreate';
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);

  // aggiunte suggerite da M. Cantù.inizio
  // i dati sono comunque parametrizzati sul file di configurazione

  // 1. pool di thread
  if TB110FParametriServer.Impostazioni_PoolSize > 0 then
  begin
    SchedulerOfThreadPool:=TIdSchedulerOfThreadPool.Create(FServer);
    SchedulerOfThreadPool.PoolSize:=TB110FParametriServer.Impostazioni_PoolSize;
    FServer.Scheduler:=SchedulerOfThreadPool;
  end;

  // 2. max concurrent connections
  FServer.MaxConnections:=TB110FParametriServer.Impostazioni_MaxConnections;
  // aggiunte suggerite da M. Cantù.fine

  // scommentare per avviare automaticamente il server una volta lanciato
  // senza dover premere il pulsante Start
  //StartServer;
end;

procedure TB110FForm.StartServer;
begin
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(EditPort.Text);
    FServer.Active := True;

    TLogger.Debug('Form StartServer');
  end;
end;

procedure TB110FForm.swcLiveViewClick(Sender: TObject);
var
  LOn: Boolean;
begin
  LOn:=(Sender as TToggleSwitch).IsOn;
  if LOn then
    (Sender as TToggleSwitch).ThumbColor:=clLime
  else
    (Sender as TToggleSwitch).ThumbColor:=clSilver;
  TLogger.SetLiveView(LOn);
end;

end.
