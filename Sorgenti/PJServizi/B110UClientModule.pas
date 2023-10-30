unit B110UClientModule;

interface

uses
  System.Classes,
  System.SysUtils,
  ClientClassesUnit1,
  Datasnap.DSClientRest;

type
  TB110FClientModule = class(TDataModule)
    DSRestConnection1: TDSRestConnection;
  private
    FInstanceOwner: Boolean;
    FServerMethods1Client: TB110FServerMethodsDMClient;
    function GetServerMethods1Client: TB110FServerMethodsDMClient;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property ServerMethods1Client: TB110FServerMethodsDMClient read GetServerMethods1Client write FServerMethods1Client;

end;

var
  B110FClientModule: TB110FClientModule;

implementation

{$R *.dfm}

constructor TB110FClientModule.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TB110FClientModule.Destroy;
begin
  FServerMethods1Client.Free;
  inherited;
end;

function TB110FClientModule.GetServerMethods1Client: TB110FServerMethodsDMClient;
begin
  if FServerMethods1Client = nil then
    FServerMethods1Client:= TB110FServerMethodsDMClient.Create(DSRestConnection1, FInstanceOwner);
  Result := FServerMethods1Client;
end;

end.
