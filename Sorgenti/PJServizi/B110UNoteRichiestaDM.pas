unit B110UNoteRichiestaDM;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  B110USharedTypes,
  B110UUtils,
  C018UIterAutDM,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  FunzioniGenerali,
  R015UDatasnapRestDM,
  W010URichiestaAssenzeDM,
  System.SysUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, System.Classes, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Oracle, Web.HTTPApp;

type
  TB110FNoteRichiestaDM = class(TR015FDatasnapRestDM)
    selT850: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    FIdRichiesta: Integer;
    FNoteLivello: TNoteLivello;
    procedure SetIdRichiesta(Value: Integer);
    procedure SetNoteLivello(Value: TNoteLivello);
    function GetDatiRichiesta(PId: Integer; var RIter, RCodIter, RErrMsg: String): Boolean;
    procedure ImpostaNote(var RRisultato: TRisultato);
    procedure GetNote(var RRisultato: TRisultato);
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  public
    property IdRichiesta: Integer write SetIdRichiesta;
    property NoteLivello: TNoteLivello write SetNoteLivello;
  end;

implementation

uses
  Datasnap.DSHTTPWebBroker;

{$R *.dfm}

{ TB110FNoteRichiestaDM }

procedure TB110FNoteRichiestaDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FIdRichiesta:=0;
end;

procedure TB110FNoteRichiestaDM.SetIdRichiesta(Value: Integer);
begin
  if Value <= 0 then
    raise EC200InvalidParameter.Create(Format('L''ID richiesta indicato non è valido: %d',[Value]));

  FIdRichiesta:=Value;
end;

procedure TB110FNoteRichiestaDM.SetNoteLivello(Value: TNoteLivello);
begin
  FNoteLivello:=Value;
end;

function TB110FNoteRichiestaDM.GetDatiRichiesta(PId: Integer; var RIter, RCodIter, RErrMsg: String): Boolean;
begin
  Result:=False;
  RErrMsg:='';

  // estrae iter e codice struttura della richiesta
  selT850.SetVariable('ID',PId);
  selT850.Execute;
  if selT850.Eof then
  begin
    RErrMsg:=Format('La richiesta %d non è presente in archivio!',[FIdRichiesta]);
    Exit;
  end;

  // valorizza alcuni dati legati alla richiesta
  RIter:=selT850.FieldAsString('ITER');
  RCodIter:=selT850.FieldAsString('COD_ITER');

  Result:=True;
end;

procedure TB110FNoteRichiestaDM.GetNote(var RRisultato: TRisultato);
var
  C018: TC018FIterAutDM;
  LIter: String;
  LCodIter: String;
  LNote: TNoteRichiesta;
  LErrore: String;
begin
  if not GetDatiRichiesta(FIdRichiesta,LIter,LCodIter,LErrore) then
  begin
    RRisultato.AddError(TErrorCode.Generic,LErrore);
    Exit;
  end;

  C018:=TC018FIterAutDM.Create(Owner);
  try
    C018.Responsabile:=True;
    C018.AccessoReadOnly:=False;
    C018.Iter:=LIter;
    C018.CodIter:=LCodIter;
    C018.Id:=FIdRichiesta;

    // legge le note della richiesta indicata
    //LNote:=C018.LeggiNoteComplete(False);

    LNote:=TNoteRichiesta.Create;
    if C018.LeggiNote(LNote,LErrore) then
    begin
      // prepara risultato servizio
      RRisultato.Output:=LNote;
      RRisultato.AddInfo(Format('Note della richiesta %d',[FIdRichiesta]));
    end
    else
    begin
      RRisultato.AddError(TErrorCode.Generic,LErrore);
    end;
  finally
    FreeAndNil(C018);
  end;
end;

procedure TB110FNoteRichiestaDM.ImpostaNote(var RRisultato: TRisultato);
var
  C018: TC018FIterAutDM;
  LIter: String;
  LCodIter: String;
  LNote: String;
  LErrore: String;
begin
  if not GetDatiRichiesta(FIdRichiesta,LIter,LCodIter,LErrore) then
  begin
    RRisultato.AddError(TErrorCode.Generic,LErrore);
    Exit;
  end;

  C018:=TC018FIterAutDM.Create(Owner);
  try
    C018.Responsabile:=True;
    C018.AccessoReadOnly:=False;
    C018.Iter:=LIter;
    C018.CodIter:=LCodIter;
    C018.Id:=FIdRichiesta;

    // imposta le note della richiesta indicata
    LNote:=C018.SetNote(FNoteLivello.Note,FNoteLivello.Livello);

    RRisultato.AddInfo(Format('Note della richiesta %d impostate: %s',[FIdRichiesta,LNote]));
  finally
    FreeAndNil(C018);
  end;
end;

function TB110FNoteRichiestaDM.ControlloParametri: TResCtrl;
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


  if GetDataSnapWebModule.Request.MethodType = TMethodType.mtPut then
  begin
    // controlla parametri input

    // controlla indicazione note
    if FNoteLivello = nil then
    begin
      Result.Messaggio:=Format('Le note non sono state indicate!',[]);
      Exit;
    end;

    // validità note
    Result:=FNoteLivello.Check;
    if not Result.Ok then
      Exit;
  end;

  Result.Ok:=True;
end;

procedure TB110FNoteRichiestaDM.Esegui(var RRisultato: TRisultato);
begin
  if FNoteLivello = nil then
    GetNote(RRisultato)
  else
    ImpostaNote(RRisultato);
end;

end.
