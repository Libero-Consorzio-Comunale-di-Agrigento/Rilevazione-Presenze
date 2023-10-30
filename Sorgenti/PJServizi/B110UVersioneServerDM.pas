unit B110UVersioneServerDM;

interface

uses
  A000UCostanti,
  A000Versione,
  B110USharedTypes,
  B110UUtils,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  FunzioniGenerali,
  R015UDatasnapRestDM,
  System.SysUtils,
  System.Classes;

type
  TB110FVersioneServerDM = class(TR015FDatasnapRestDM)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    // dati di versione del server
    FTipoVersione: String;
    FVersioneServer: TInfoVersioneSW;
    procedure SetTipoVersione(Value: String);
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  public
    property TipoVersione: String read FTipoVersione write SetTipoVersione;
  end;

implementation

{$R *.dfm}

procedure TB110FVersioneServerDM.DataModuleCreate(Sender: TObject);
begin
  inherited;

  FTipoVersione:='';

  // dati versione server
  FVersioneServer:=TInfoVersioneSW.Create('?','?');
 end;

procedure TB110FVersioneServerDM.DataModuleDestroy(Sender: TObject);
begin
  try FreeAndNil(FVersioneServer); except end;
  inherited;
end;

procedure TB110FVersioneServerDM.SetTipoVersione(Value: String);
begin
  if Value = '' then
    raise EC200InvalidParameter.Create('Il tipo di versione non è indicato!');

  if not TFunzioniGenerali._In(Value,[TInfoVersioneSW.TIPO_VERSIONE_PA,TInfoVersioneSW.TIPO_VERSIONE_AM]) then
    raise EC200InvalidParameter.Create(Format('Il tipo di versione non è valido: %s!',[FTipoVersione]));

  FTipoVersione:=Value;
end;

function TB110FVersioneServerDM.ControlloParametri: TResCtrl;
begin
  Result.Ok:=False;

  // tipo versione
  if FTipoVersione = '' then
  begin
    Result.Messaggio:='Il tipo di versione non è indicato!';
    Exit;
  end;

  if not TFunzioniGenerali._In(FTipoVersione,[TInfoVersioneSW.TIPO_VERSIONE_PA,TInfoVersioneSW.TIPO_VERSIONE_AM]) then
  begin
    Result.Messaggio:=Format('Il tipo di versione non è valido: %s!',[FTipoVersione]);
    Exit;
  end;

  Result.Ok:=True;
  Result.Messaggio:='';
end;

procedure TB110FVersioneServerDM.Esegui(var RRisultato: TRisultato);
var
  LRes: TOutputVersioneServer;
begin
  // prepara l'output
  RRisultato.Output:=TOutputVersioneServer.Create;
  LRes:=TOutputVersioneServer(RRisultato.Output);

  LRes.Versione.Versione:=VersionePA;
  LRes.Versione.Build:=BuildPA;

  RRisultato.AddInfo(Format('Versione server %s: %s',[FTipoVersione,LRes.Versione.ToString]));
end;

end.
