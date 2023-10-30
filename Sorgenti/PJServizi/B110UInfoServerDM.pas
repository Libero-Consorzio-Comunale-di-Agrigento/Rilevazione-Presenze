unit B110UInfoServerDM;

interface

uses
  A000UCostanti,
  B110USharedTypes,
  B110UUtils,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  FunzioniGenerali,
  R015UDatasnapRestDM,
  System.SysUtils,
  System.Classes;

type
  TB110FInfoServerDM = class(TR015FDatasnapRestDM)
    procedure DataModuleCreate(Sender: TObject);
  private
    FDatoServer: String;
    procedure SetDatoServer(Value: String);
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  public
    property DatoServer: String write SetDatoServer;
  end;

const
  VAL_DATO_PARAM_INI = 'PARAMETRI_INI';
  VAL_DATO_ARR: array of String = [
    VAL_DATO_PARAM_INI
  ];

implementation

{$R *.dfm}

procedure TB110FInfoServerDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FDatoServer:='';
end;

procedure TB110FInfoServerDM.SetDatoServer(Value: String);
begin
  // controllo parametro "dato"
  if Value = '' then
    raise EC200InvalidParameter.Create('Il parametro Dato Server non può essere vuoto!');

  if not TFunzioniGenerali._In(Value,VAL_DATO_ARR) then
    raise EC200InvalidParameter.CreateFmt('Valore non ammesso per il parametro Dato Server: %s',[Value]);

  FDatoServer:=Value;
end;

function TB110FInfoServerDM.ControlloParametri: TResCtrl;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  // controllo parametro "dato"
  if FDatoServer = '' then
  begin
    Result.Messaggio:=Format('Il parametro Dato Server non è indicato',[]);
    Exit;
  end;

  if not TFunzioniGenerali._In(FDatoServer,VAL_DATO_ARR) then
  begin
    Result.Messaggio:=Format('Valore non ammesso per il parametro Dato Server: %s',[FDatoServer]);
    Exit;
  end;

  Result.Ok:=True;
end;

procedure TB110FInfoServerDM.Esegui(var RRisultato: TRisultato);
begin
  if FDatoServer = VAL_DATO_PARAM_INI then
  begin
    RRisultato.AddInfo('Parametri di configurazione del server');
    RRisultato.AddInfo(TB110FParametriServer.ToString);
  end;
end;

end.
