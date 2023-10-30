unit B110UClientModule;

interface

uses
  System.SysUtils, System.Classes, B110UServerMethodsDMClient, Datasnap.DSClientRest,
  FireDAC.Comp.Client, A000UCostanti, B110USharedTypes, C200UWebServicesTypes,
  Data.FireDACJSONReflect, Generics.Collections, Variants;

type
  TB110FClientModule = class(TDataModule)
    DSRestConnection1: TDSRestConnection;
  private
    FInstanceOwner: Boolean;
    FB110FServerMethodsDMClient: TB110FServerMethodsDMClient;
    function GetB110FServerMethodsDMClient: TB110FServerMethodsDMClient;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; PHost, PUrlPath, PProtocol: String; PPort: Integer); overload;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property B110FServerMethodsDMClient: TB110FServerMethodsDMClient read GetB110FServerMethodsDMClient write FB110FServerMethodsDMClient;

    function GetTabellaDizionarioSRV(InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PDataset: TFDMemTable; const PTabella, PParam1: String; const PApplicaFiltroDizionario: Boolean): TResCtrl;
    function GetListaKeyValue(PDataset: TFDMemTable; PNomeCampoKey, PNomeCampoValue: String): TList<TPair<String,String>>;
    function GetDefaultCode(PDataset: TFDMemTable; PFieldDefault, PNomeCampoKey: String): Variant;
end;

var
  B110FClientModule: TB110FClientModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TB110FClientModule.Create(AOwner: TComponent; PHost, PUrlPath, PProtocol: String; PPort: Integer);
begin
  inherited Create(AOwner);
  FInstanceOwner := True;

  DSRestConnection1.Host:=PHost;
  DSRestConnection1.UrlPath:=PUrlPath;
  DSRestConnection1.Port:=PPort;
  DSRestConnection1.Protocol:=PProtocol;

  {if Pos('/',PHost) > 0 then
  begin
    DSRestConnection1.Host:=Copy(PHost,1,Pos('/',PHost) - 1);
    DSRestConnection1.UrlPath:=Copy(PHost,Pos('/',PHost) + 1,PHost.Length);
  end;
  DSRestConnection1.Port:=PPort;
  if PPort = 443 then
    DSRestConnection1.Protocol:='https'
  else
    DSRestConnection1.Protocol:='http';}
end;

destructor TB110FClientModule.Destroy;
begin
  FB110FServerMethodsDMClient.Free;
  inherited;
end;

function TB110FClientModule.GetB110FServerMethodsDMClient: TB110FServerMethodsDMClient;
begin
  if FB110FServerMethodsDMClient = nil then
    FB110FServerMethodsDMClient:= TB110FServerMethodsDMClient.Create(DSRestConnection1, FInstanceOwner);
  Result := FB110FServerMethodsDMClient;
end;

function TB110FClientModule.GetTabellaDizionarioSRV(InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PDataset: TFDMemTable; const PTabella, PParam1: String; const PApplicaFiltroDizionario: Boolean): TResCtrl;
var
  LRes: TRisultato;
  LDataSetList: TFDJSONDataSets;
begin
  // chiude il dataset dizionario
  PDataset.Close;

  // estrae il dizionario richiesto dal server
  LRes:=B110FServerMethodsDMClient.Dizionario(InfoClient.PrepareForServer,
                                              ParametriLogin.PrepareForServer,
                                              PTabella,
                                              PParam1,
                                              PApplicaFiltroDizionario);

  // verifica risultato
  Result:=LRes.Check(TOutputDizionario);

  if not Result.Ok then
    Exit
  else
  begin
    // risposta servizio ok
    try
      LDataSetList:=(LRes.Output as TOutputDizionario).JSONDatasets;
      PDataset.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
      PDataset.Open;

      FreeAndNil(LDataSetList);  ///valutare spostamento in try/finally fuori da try except
    except
      on E: Exception do
      begin
        Result.Ok:=False;
        Result.Messaggio:=E.Message;
        FreeAndNil(LDataSetList);
        Exit;
      end;
    end;
  end;
end;

function TB110FClientModule.GetListaKeyValue(PDataset: TFDMemTable; PNomeCampoKey, PNomeCampoValue: String): TList<TPair<String, String>>;
var LLista: TList<TPair<String, String>>;
    LPair: TPair<String,String>;
begin
  Result:=nil;

  if Assigned(PDataset) then
    if PDataset.Active then
    begin
      LLista:=TList<TPair<String, String>>.Create;

      while not PDataset.Eof do
      begin
        LPair:=TPair<String,String>.Create(PDataset.FieldByName(PNomeCampoKey).AsString,
                                           PDataset.FieldByName(PNomeCampoValue).AsString);
        LLista.Add(LPair);

        PDataset.Next;
      end;

      Result:=LLista;
    end;
end;

function TB110FClientModule.GetDefaultCode(PDataset: TFDMemTable; PFieldDefault, PNomeCampoKey: String): Variant;
begin
  Result:=Null;

  if Assigned(PDataset) then
    if PDataset.Locate(PFieldDefault, 'S', []) then
      Result:=PDataset.FieldByName(PNomeCampoKey).AsVariant;
end;

end.
