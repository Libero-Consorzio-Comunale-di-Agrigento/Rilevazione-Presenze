unit B110UConsegnaCedoliniDM;

interface

uses
  A000UCostanti,
  B110USharedTypes,
  B110UUtils,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  FunzioniGenerali,
  R015UDatasnapRestDM,
  W017UStampaCedolinoDM,
  System.SysUtils,
  System.Classes;

type
  TB110FConsegnaCedoliniDM = class(TR015FDatasnapRestDM)
    procedure DataModuleCreate(Sender: TObject);
  private
    FIdCedolino: Integer;
    procedure SetIdCedolino(Value: Integer);
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  public
    property IdCedolino: Integer write SetIdCedolino;
  end;

implementation

{$R *.dfm}

uses
  A000UInterfaccia;

{ TB110FConsegnaCedoliniDM }

procedure TB110FConsegnaCedoliniDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FIdCedolino:=0;
end;

procedure TB110FConsegnaCedoliniDM.SetIdCedolino(Value: Integer);
begin
  if Value <= 0 then
    raise EC200InvalidParameter.Create(Format('L''ID cedolino indicato non è valido: %d',[Value]));

  FIdCedolino:=Value;
end;

function TB110FConsegnaCedoliniDM.ControlloParametri: TResCtrl;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  // id cedolino
  if FIdCedolino = 0 then
  begin
    Result.Messaggio:='L''ID del cedolino non è indicato!';
    Exit;
  end;

  if FIdCedolino < 0 then
  begin
    Result.Messaggio:=Format('L''ID del cedolino non è valido: %d!',[FIdCedolino]);
    Exit;
  end;

  Result.Ok:=True;
end;

procedure TB110FConsegnaCedoliniDM.Esegui(var RRisultato: TRisultato);
var
  W017DM: TW017FStampaCedolinoDM;
begin
  // imposta la data di consegna del cedolino (utilizzando il datamodule W017)
  W017DM:=TW017FStampaCedolinoDM.Create(nil);
  try
    W017DM.ImpostaDataConsegna(FIdCedolino);
    RRisultato.AddInfo(Format('Data di consegna aggiornata su id cedolino %d',[FIdCedolino]));
  finally
    FreeAndNil(W017DM);
  end;
end;

end.
