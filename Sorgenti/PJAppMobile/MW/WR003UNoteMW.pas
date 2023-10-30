unit WR003UNoteMW;

interface

uses
  A000UCostanti,
  B110UClientModule,
  B110USharedTypes,
  C018UIterAutDM,
  Data.FireDACJSONReflect,
  FireDAC.Comp.Client,
  System.Generics.Collections,
  System.Sensors, C200UWebServicesTypes, C200UWebServicesUtils, System.SysUtils, System.Classes,
  System.StrUtils, FunzioniGenerali, System.Math, WM000UConstants, Data.DB;

type

  TWR003FNoteMW = class(TObject)
    private
      FIDRichiesta: Integer;
      FLivelloRichiesta: Integer;

      FNoteRichiesta: TNoteRichiesta;
      FIndex: Integer;

      FAbilitazioneFunzione: String;
      FEof: Boolean;

      function GetAutorizzazione: String;
      function GetDescrizioneLivello: String;
      function GetInModifica: Boolean;
      function GetIntestazione: String;
      function GetLivelloNota: Integer;
      function GetNominativo: String;
      function GetNota: String;
      function GetEof: Boolean;
      procedure SetNota(const Value: String);
    public
      constructor Create(PIDRichiesta, PLivelloRichiesta: Integer; PAbilitazioneFunzione: String);
      destructor Destroy; override;

      property LivelloNota: Integer read GetLivelloNota;
      property Intestazione: String read GetIntestazione;
      property Nota: String read GetNota write SetNota;
      property DescrizioneLivello: String read GetDescrizioneLivello;
      property Nominativo: String read GetNominativo;
      property Autorizzazione: String read GetAutorizzazione;
      property InModifica: Boolean read GetInModifica;
      property Eof: Boolean read GetEof;

      function First: Boolean;
      function Next: Boolean;
      function Prior: Boolean;

      function Locate(PLivello: Integer): Boolean;

      function GetNoteRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;
      function SetNoteRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;

      //function GetNoteRichiestaC018(C018: TC018FIterAutDM): TResCtrl;
      //function SetNoteRichiestaC018(C018: TC018FIterAutDM): TResCtrl;
  end;

implementation

constructor TWR003FNoteMW.Create(PIDRichiesta, PLivelloRichiesta: Integer; PAbilitazioneFunzione: String);
begin
  FIDRichiesta:=PIDRichiesta;
  FLivelloRichiesta:=PLivelloRichiesta;
  FIndex:=0;
  FAbilitazioneFunzione:=PAbilitazioneFunzione;
end;

destructor TWR003FNoteMW.Destroy;
begin
  FreeAndNil(FNoteRichiesta);
  inherited;
end;

function TWR003FNoteMW.First: Boolean;
begin
  if Assigned(FNoteRichiesta) then
  begin
    if Length(FNoteRichiesta.NoteArr)>=1 then
    begin
      FIndex:=Low(FNoteRichiesta.NoteArr);
      FEof:=False;
      Result:=True;
    end
    else
      Result:=False;
  end
  else
    Result:=False;
end;

function TWR003FNoteMW.Next: Boolean;
begin
  if FIndex < High(FNoteRichiesta.NoteArr) then
  begin
    FIndex:=FIndex+1;
    Result:=True;
  end
  else if FIndex = High(FNoteRichiesta.NoteArr) then
  begin
    FEof:=True;
    Result:=False;
  end
  else
    Result:=False;
end;

function TWR003FNoteMW.Prior: Boolean;
begin
  if FIndex > Low(FNoteRichiesta.NoteArr) then
  begin
    FIndex:=FIndex-1;
    FEof:=False;
    Result:=True;
  end
  else
    Result:=False;
end;

function TWR003FNoteMW.GetEof: Boolean;
begin
  if Assigned(FNoteRichiesta) then
  begin
    Result:=FEof;
  end
  else
    Result:=True;
end;

function TWR003FNoteMW.GetAutorizzazione: String;
begin
  if Assigned(FNoteRichiesta) then
    Result:=FNoteRichiesta.NoteArr[FIndex].GetAutorizzazione
  else
    Result:='';
end;

function TWR003FNoteMW.GetDescrizioneLivello: String;
begin
  if Assigned(FNoteRichiesta) then
    Result:=FNoteRichiesta.NoteArr[FIndex].GetDescLivello
  else
    Result:='';
end;

function TWR003FNoteMW.GetInModifica: Boolean;
begin
  if Assigned(FNoteRichiesta) then
    Result:=(FAbilitazioneFunzione = 'S') and (FLivelloRichiesta = FNoteRichiesta.NoteArr[FIndex].Livello)
  else
    Result:=False;
end;

function TWR003FNoteMW.GetIntestazione: String;
begin
  if Assigned(FNoteRichiesta) then
    Result:=FNoteRichiesta.NoteArr[FIndex].GetIntestazione
  else
    Result:='';
end;

function TWR003FNoteMW.GetLivelloNota: Integer;
begin
  if Assigned(FNoteRichiesta) then
    Result:=FNoteRichiesta.NoteArr[FIndex].Livello
  else
    Result:=-1;
end;

function TWR003FNoteMW.GetNominativo: String;
begin
  if Assigned(FNoteRichiesta) then
    Result:=FNoteRichiesta.NoteArr[FIndex].Nominativo
  else
    Result:='';
end;

function TWR003FNoteMW.GetNota: String;
begin
  if Assigned(FNoteRichiesta) then
    Result:=FNoteRichiesta.NoteArr[FIndex].GetNoteVis
  else
    Result:='';
end;

function TWR003FNoteMW.Locate(PLivello: Integer): Boolean;
begin
  if Assigned(FNoteRichiesta) then
  begin
    First;

    while not Eof do
    begin
      if LivelloNota = PLivello then
      begin
        Result:=True;
        Exit;
      end;

      Next;
    end;

    Result:=False;
  end
  else
    Result:=False;
end;

procedure TWR003FNoteMW.SetNota(const Value: String);
begin
  if Assigned(FNoteRichiesta) then
    FNoteRichiesta.NoteArr[FIndex].Note:=Value;
end;

function TWR003FNoteMW.SetNoteRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;
var LRes: TRisultato;
begin
  try
    // imposta le note
    LRes:=B110.B110FServerMethodsDMClient.SetNoteRichiesta(InfoClient.PrepareForServer,
                                                           ParametriLogin.PrepareForServer,
                                                           FIDRichiesta,
                                                           FNoteRichiesta.NoteArr[FIndex].Clone,
                                                           '');
    // verifica risultato
    Result:=LRes.Check(nil);
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

function TWR003FNoteMW.GetNoteRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;
var LRes: TRisultato;
begin
  try
    // legge le note della richiesta corrente
    LRes:=B110.B110FServerMethodsDMClient.NoteRichiesta(InfoClient.PrepareForServer,
                                                        ParametriLogin.PrepareForServer,
                                                        FIDRichiesta,
                                                        '');
    Result:=LRes.Check(TNoteRichiesta);

    if Result.Ok then
    begin
      FNoteRichiesta:=TNoteRichiesta.Create;
      FNoteRichiesta.Assign(LRes.Output as TNoteRichiesta);
      First;
    end;
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

{function TWR003FNoteMW.GetNoteRichiestaC018(C018: TC018FIterAutDM): TResCtrl;
var LErrore: String;
begin
  if Assigned(FNoteRichiesta) then
    FreeAndNil(FNoteRichiesta);

  Result.Clear;
  try
    if C018.LeggiNote(FNoteRichiesta,LErrore) then
      Result.Ok:=True
    else
      Result.Messaggio:=LErrore;
  except
    on E: Exception do
      Result.Messaggio:=E.Message;
  end;
end;

function TWR003FNoteMW.SetNoteRichiestaC018(C018: TC018FIterAutDM): TResCtrl;
begin
  try
    C018.SetNote(FNoteRichiesta.NoteArr[FIndex].Note, FNoteRichiesta.NoteArr[FIndex].Livello);
  except
    on E: Exception do
      Result.Messaggio:=E.Message;
  end;
end;}

end.
