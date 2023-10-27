unit R017UDatasnapRestAutRichiesteDM;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  R015UDatasnapRestDM,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  B110UUtils,
  B110USharedTypes,
  C018UIterAutDM,
  C180FunzioniGenerali,
  W010URichiestaAssenzeDM,
  System.SysUtils, System.Classes;

type
  TR017FDatasnapRestAutRichiesteDM = class(TR015FDatasnapRestDM)
    procedure DataModuleCreate(Sender: TObject);
  private
    FIdRichiesta: Integer;
    FAutorizzazione: String;
    procedure SetIdRichiesta(Value: Integer);
    procedure SetAutorizzazione(Value: String);
  protected
    function ControlloParametri: TResCtrl; override;
  public
    property IdRichiesta: Integer read FIdRichiesta write SetIdRichiesta;
    property Autorizzazione: String read FAutorizzazione write SetAutorizzazione;
  end;

implementation

{$R *.dfm}

{ TR017FDatasnapRestAutRichiesteDM }

procedure TR017FDatasnapRestAutRichiesteDM.DataModuleCreate(Sender: TObject);
begin
  inherited;

  FIdRichiesta:=0;
  FAutorizzazione:='';
end;

procedure TR017FDatasnapRestAutRichiesteDM.SetIdRichiesta(Value: Integer);
begin
  if Value <= 0 then
    raise EC200InvalidParameter.Create(Format('L''ID richiesta indicato non è valido: %d',[Value]));

  FIdRichiesta:=Value;
end;

procedure TR017FDatasnapRestAutRichiesteDM.SetAutorizzazione(Value: String);
begin
  if not R180In(Value,['',C018SI,C018NO]) then
    raise EC200InvalidParameter.Create(Format('Il valore di autorizzazione indicato non è valido: %s',[Value]));

  FAutorizzazione:=Value;
end;

function TR017FDatasnapRestAutRichiesteDM.ControlloParametri: TResCtrl;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  // id richiesta
  if FIdRichiesta = 0 then
  begin
    Result.Messaggio:='L''ID della richiesta non è indicato!';
    Exit;
  end;

  if FIdRichiesta < 0 then
  begin
    Result.Messaggio:=Format('L''ID della richiesta non è valido: %d!',[FIdRichiesta]);
    Exit;
  end;

  // autorizzazione
  if not R180In(FAutorizzazione,['',C018SI,C018NO]) then
  begin
    Result.Messaggio:=Format('Il valore di autorizzazione indicato non è valido: %s',[FAutorizzazione]);
    Exit;
  end;

  Result.Ok:=True;
end;

end.
