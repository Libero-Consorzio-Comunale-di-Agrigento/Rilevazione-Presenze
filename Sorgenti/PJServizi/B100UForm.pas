unit B100UForm;

interface

uses
  SysUtils, Classes, Forms,
  IdHTTPWebBrokerBridge, Web.HTTPApp, Vcl.Controls, Vcl.StdCtrls,
  ShellAPI, Winapi.Windows, System.UITypes, System.IOUtils;

type
  TB100FForm = class(TForm)
    grpInfoServer: TGroupBox;
    lblPortaServer: TLabel;
    edtPortaServer: TEdit;
    grpGestServer: TGroupBox;
    btnStart: TButton;
    btnStop: TButton;
    lblStatoServer: TLabel;
    edtStatoServer: TEdit;
    grpGestClient: TGroupBox;
    btnRunClient: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnRunClientClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    LClientPath: String;
    procedure AggiornaInterfacciaServer;
  end;

var
  B100FForm: TB100FForm;

const
  B100_TEST_CLIENT = 'B100PWSMedpRepositary.exe';

implementation

uses SockApp;

{$R *.dfm}

procedure TB100FForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FServer);
end;

procedure TB100FForm.FormShow(Sender: TObject);
begin
  //Fatto come wizard di DataSnap REST server in XE4: non serve più l'app debugger
  FServer:=TIdHTTPWebBrokerBridge.Create(Self);
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort:=StrToInt(edtPortaServer.Text);
    //FServer.Active:=True;
  end;

  edtPortaServer.Text:=Format('%d',[FServer.DefaultPort]);
  AggiornaInterfacciaServer;
  // determina posizione client di test
  LClientPath:=ExtractFilePath(Application.ExeName) + B100_TEST_CLIENT;
  btnRunClient.Enabled:=TFile.Exists(LClientPath);
end;

procedure TB100FForm.AggiornaInterfacciaServer;
begin
  if FServer.Active then
    edtStatoServer.Text:='Running'
  else
    edtStatoServer.Text:='Stopped';
  btnStart.Enabled:=not FServer.Active;
  btnStop.Enabled:=FServer.Active;
end;

procedure TB100FForm.btnRunClientClick(Sender: TObject);
{http://localhost:8080/datasnap/rest/TB100FWSMedpRepositaryDM/GetWS/MEDP_TEST
 http://192.0.0.106/IrisApp/B100PWSMedpRepositary_IIS.dll/datasnap/rest/TB100FWSMedpRepositaryDM/GetWS/MEDP_TEST
}
begin
  // esegue client
  if TFile.Exists(LClientPath) then
    ShellExecute(0,'open',PChar(LClientPath),'',nil,SW_SHOWNORMAL);
end;

procedure TB100FForm.btnStartClick(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  try
    FServer.DefaultPort:=StrToInt(edtPortaServer.Text);
    FServer.Active:=True;
  finally
    AggiornaInterfacciaServer;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TB100FForm.btnStopClick(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  try
    FServer.Active:=False;
  finally
    AggiornaInterfacciaServer;
    Screen.Cursor:=crDefault;
  end;
end;

initialization
  TWebAppSockObjectFactory.Create('TWSRest')

end.

