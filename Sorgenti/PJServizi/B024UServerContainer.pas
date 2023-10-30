unit B024UServerContainer;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.SvcMgr,
  IdCustomTCPServer,
  IdCustomHTTPServer,
  IdSoapServerHTTP,
  IdBaseComponent,
  IdComponent,
  IdSoapComponent,
  IdSoapITIProvider,
  IdSoapServer;

type
  TB024FServerContainer = class(TService)
    IdSoapServer1: TIdSoapServer;
    IdSOAPServerHTTP1: TIdSOAPServerHTTP;
    procedure ServiceStart(Sender: TService; var Started: Boolean);
  private
    { Private declarations }
  protected
    function DoStop: Boolean; override;
    function DoPause: Boolean; override;
    function DoContinue: Boolean; override;
    procedure DoInterrogate; override;
  public
    function GetServiceController: TServiceController; override;
  end;

var
  B024FServerContainer: TB024FServerContainer;

implementation

uses
  Winapi.Windows,
  B024UADSCatanzaroDM,
  FunzioniGenerali;

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  B024FServerContainer.Controller(CtrlCode);
end;

function TB024FServerContainer.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

function TB024FServerContainer.DoContinue: Boolean;
begin
  Result := inherited;
end;

procedure TB024FServerContainer.DoInterrogate;
begin
  inherited;
end;

function TB024FServerContainer.DoPause: Boolean;
begin
  Result := inherited;
end;

function TB024FServerContainer.DoStop: Boolean;
begin
  IdSoapServer1.Active:=False;
  IdSOAPServerHTTP1.Active:=False;
  Result:=inherited;
  TLogger.Debug(Format('Server %s arrestato',[DisplayName,IdSOAPServerHTTP1.DefaultPort]));
end;

procedure TB024FServerContainer.ServiceStart(Sender: TService; var Started: Boolean);
begin
  IdSOAPServerHTTP1.DefaultPort:=GConfig.Port;
  IdSOAPServerHTTP1.Active:=True;
  IdSoapServer1.Active:=True;
  TLogger.Debug(Format('Server %s avviato e in ascolto sulla porta %d',[DisplayName,IdSOAPServerHTTP1.DefaultPort]));
  TLogger.Debug('URL relativo per ottenere il WSDL',IdSOAPServerHTTP1.WSDLPath);
  TLogger.Debug('URL relativo per i servizi SOAP',IdSOAPServerHTTP1.SOAPPath);
end;

end.

