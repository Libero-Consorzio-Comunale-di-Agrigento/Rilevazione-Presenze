unit WM011UDatiGiornalieriMW;

interface

uses
  A000UCostanti,
  A000Versione,
  B110USharedTypes,
  C200UWebServicesTypes,
  B110UClientModule,
  FunzioniGenerali,
  SysUtils,
  Classes,
  Generics.Defaults,
  Generics.Collections,
  DateUtils;

type

  TWM011FDatiGiornalieriMW = class(TObject)
    private
      FData: TDateTime;
      FDatiGiornalieri: TOutputDatiGiornalieri;

    public
      property Data: TDateTime read FData write FData;

      constructor Create(PData: TDateTime);
      destructor Destroy; override;

      function AggiornaDatiGGSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;

      function GetTimbrature: TStringList;
      function GetGiustificativi: TStringList;
      function GetAnomalie: TList<TPair<String,String>>;
      function GetDayOfWeek: String;
      function GetDebitoOrario: String;
      function GetOreRese: String;
      function GetSaldo: String;
      function GetOreEscluse: String;
      function GetTimbNominali: String;
      function GetReperibilitaPianificata: String;

    end;

implementation

{ TWM011FDatiGiornalieriMW }

constructor TWM011FDatiGiornalieriMW.Create(PData: TDateTime);
begin
  FData:=PData;
  FDatiGiornalieri:=TOutputDatiGiornalieri.Create;
end;

destructor TWM011FDatiGiornalieriMW.Destroy;
begin
  if Assigned(FDatiGiornalieri) then
    FreeAndnil(FDatiGiornalieri);
  inherited;
end;

function TWM011FDatiGiornalieriMW.AggiornaDatiGGSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;
var
  LRes: TRisultato;
begin
  if not Assigned(B110) or not Assigned(Infoclient) or not Assigned(ParametriLogin) then
  begin
    Result.Ok:=False;
    Result.Messaggio:='Impossibile aggiornare i dati giornalieri, parametri incompleti';
    Exit;
  end;
  try
    LRes:=B110.B110FServerMethodsDMClient.DatiGiornalieri(InfoClient.PrepareForServer,
                                                          ParametriLogin.PrepareForServer,
                                                          FData,
                                                          '');
    Result:=LRes.Check(TOutputDatiGiornalieri);
    if Result.Ok then
    begin
      if Assigned(FDatiGiornalieri) then
        FreeAndNil(FDatiGiornalieri);
      FDatiGiornalieri:=TOutputDatiGiornalieri.Create;
      FDatiGiornalieri.Assign(LRes.Output);
    end;
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

function TWM011FDatiGiornalieriMW.GetAnomalie: TList<TPair<String, String>>;
var i: Integer;
    LAnomalie: TList<TPair<String, String>>;
begin
  try
    LAnomalie:=TList<TPair<String, String>>.Create();

    if Assigned(FDatiGiornalieri) then
      if Length(FDatiGiornalieri.lstAnomalie) > 0 then
        for i:=Low(FDatiGiornalieri.lstAnomalie) to High(FDatiGiornalieri.lstAnomalie) do
        begin
          LAnomalie.Add(TPair<String, String>.Create(FDatiGiornalieri.lstAnomalie[i].Item, FDatiGiornalieri.lstAnomalie[i].Value));
        end;
  except
    FreeAndNil(LAnomalie);
    raise;
  end;
  Result:=LAnomalie;
end;

function TWM011FDatiGiornalieriMW.GetGiustificativi: TStringList;
var i: Integer;
    LGiustificativi: TStringList;
begin
  try
    LGiustificativi:=TStringList.Create;

    if Assigned(FDatiGiornalieri) then
      if Length(FDatiGiornalieri.lstGiustificativi) > 0 then
        for i:=Low(FDatiGiornalieri.lstGiustificativi) to High(FDatiGiornalieri.lstGiustificativi) do
        begin
          LGiustificativi.Append(FDatiGiornalieri.lstGiustificativi[i]);
        end;
  except
    FreeAndNil(LGiustificativi);
    raise;
  end;
  Result:=LGiustificativi;
end;

function TWM011FDatiGiornalieriMW.GetTimbrature: TStringList;
var i: Integer;
    LTimbrature: TStringList;
begin
  try
    LTimbrature:=TStringList.Create;

    if Assigned(FDatiGiornalieri) then
      if Length(FDatiGiornalieri.lstTimbrature) > 0 then
        for i:=Low(FDatiGiornalieri.lstTimbrature) to High(FDatiGiornalieri.lstTimbrature) do
        begin
          LTimbrature.Append(FDatiGiornalieri.lstTimbrature[i]);
        end;
  except
    FreeAndNil(LTimbrature);
    raise;
  end;
  Result:=LTimbrature;
end;

function TWM011FDatiGiornalieriMW.GetDayOfWeek: String;
//var LDayOfWeek: Integer;
begin
  Result:=TFunzioniGenerali.NomeGiorno(FData);
  (*
  LDayOfWeek:=DayOfTheWeek(FData);
  case LDayOfWeek of
    1: Result:='lunedì';
    2: Result:='martedì';
    3: Result:='mercoledì';
    4: Result:='giovedì';
    5: Result:='venerdì';
    6: Result:='sabato';
    7: Result:='domenica';
    else Result:='';
  end;
  *)
end;

function TWM011FDatiGiornalieriMW.GetOreEscluse: String;
begin
  if Assigned(FDatiGiornalieri) then
    Result:=FDatiGiornalieri.OreEscluseGG
  else
    Result:='';
end;

function TWM011FDatiGiornalieriMW.GetOreRese: String;
begin
  if Assigned(FDatiGiornalieri) then
    Result:=FDatiGiornalieri.ResoGG
  else
    Result:='';
end;

function TWM011FDatiGiornalieriMW.GetReperibilitaPianificata: String;
begin
  if Assigned(FDatiGiornalieri) then
    Result:=FDatiGiornalieri.TurniReperibilita
  else
    Result:='';
end;

function TWM011FDatiGiornalieriMW.GetSaldo: String;
begin
  if Assigned(FDatiGiornalieri) then
    Result:=FDatiGiornalieri.SaldoGG
  else
    Result:='';
end;

function TWM011FDatiGiornalieriMW.GetDebitoOrario: String;
begin
  if Assigned(FDatiGiornalieri) then
    Result:=FDatiGiornalieri.DebitoGG
  else
    Result:='';
end;

function TWM011FDatiGiornalieriMW.GetTimbNominali: String;
begin
  if Assigned(FDatiGiornalieri) then
    Result:=FDatiGiornalieri.TimbNominali
  else
    Result:='';
end;

end.
