unit WM000UServerModule;

interface

uses
  Classes, SysUtils, uniGUIServer, uniGUIMainModule, uniGUIApplication, uIdCustomHTTPServer,
  uniGUITypes, WM000UConstants, WM000UParConfig;

type
  TWM000FServerModule = class(TUniGUIServerModule)
    procedure UniGUIServerModuleCreate(Sender: TObject);
    procedure UniGUIServerModuleDestroy(Sender: TObject);
  private
    FParConfig: TWM000FParConfig;
  protected
    procedure FirstInit; override;
  public
    property ParConfig: TWM000FParConfig read FParConfig;
  end;

function WM000FServerModule: TWM000FServerModule;

implementation

{$R *.dfm}

uses
  UniGUIVars;

function WM000FServerModule: TWM000FServerModule;
begin
  Result:=TWM000FServerModule(UniGUIServerInstance);
end;

procedure TWM000FServerModule.FirstInit;
begin
  InitServerModule(Self);
end;

procedure TWM000FServerModule.UniGUIServerModuleCreate(Sender: TObject);
begin
  FParConfig:=TWM000FParConfig.Create(FILE_CONFIG_IRISAPP, FILE_CONFIG_B110, StartPath);

  // gestione timeout sessione, max sessioni attive e max requests gestibili in parallelo
  SessionTimeout:=FParConfig.TimeoutSessione*60*1000;
  ServerLimits.MaxSessions:=FParConfig.MaxSessioni;
  ServerLimits.MaxRequests:=FParConfig.MaxRequests;

  // gestione file di log
  with ServerLogger do
  begin
    Options:=[];

    if FParConfig.LogIndyExceptions then
      Options:=Options + [logIndyExceptions];

    if FParConfig.LogSSLIndyExceptions then
      Options:=Options + [logIndySSLExceptions];

    if FParConfig.LogSessionExceptions then
      Options:=Options + [logSessionExceptions];

    ServerLogger.Enabled:=Options <> [];
  end;
end;

procedure TWM000FServerModule.UniGUIServerModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FParConfig);
end;

initialization
  RegisterServerModuleClass(TWM000FServerModule);
end.
