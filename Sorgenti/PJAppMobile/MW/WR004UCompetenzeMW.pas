unit WR004UCompetenzeMW;

interface

uses
  A000UCostanti,
  B110UClientModule,
  B110USharedTypes,
  Data.FireDACJSONReflect,
  FireDAC.Comp.Client,
  System.Generics.Collections,
  System.Sensors, C200UWebServicesTypes, C200UWebServicesUtils, System.SysUtils, System.Classes,
  System.StrUtils, FunzioniGenerali, System.Math, WM000UConstants, Data.DB;

type

  TWR004FCompetenzeMW = class(TObject)
    private
      FRiepAss: TOutputRiepilogoAssenze;
      function GetCompetenze: String;
      function GetFruito: String;
      function GetResiduo: String;
      function GetUnitaDiMisura: String;
    public
      constructor Create;
      destructor Destroy; override;

      property UnitaDiMisura: String read GetUnitaDiMisura;
      property Competenze: String read GetCompetenze;
      property Fruito: String read GetFruito;
      property Residuo: String read GetResiduo;

      function GetCompetenzeSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; const PProgressivo: Integer; const PCausale: String; const PData: TDateTime; const PDataFamiliare: TDateTime): TResCtrl;
  end;

implementation

{ TWR004FCompetenzeMW }

constructor TWR004FCompetenzeMW.Create;
begin
  FRiepAss:=TOutputRiepilogoAssenze.Create;
end;

destructor TWR004FCompetenzeMW.Destroy;
begin
  FreeAndNil(FRiepAss);
  inherited;
end;

function TWR004FCompetenzeMW.GetCompetenzeSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin;
                                              const PProgressivo: Integer; const PCausale: String; const PData, PDataFamiliare: TDateTime): TResCtrl;
var LRes: TRisultato;
begin
  try
    // legge il riepilogo delle competenze, ecc..
    LRes:=B110.B110FServerMethodsDMClient.RiepilogoAssenze(InfoClient.PrepareForServer,
                                                           ParametriLogin.PrepareForServer,
                                                           PProgressivo,
                                                           PCausale,
                                                           PData,
                                                           PDataFamiliare,
                                                           '');

    // verifica risultato
    Result:=LRes.Check(TOutputRiepilogoAssenze);
    if Result.Ok then
      FRiepAss.Assign(LRes.Output);    // valore di output
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

function TWR004FCompetenzeMW.GetFruito: String;
begin
  if Assigned(FRiepAss) then
  begin
    Result:=FRiepAss.FruitoTot;
  end
  else
    Result:='';
end;

function TWR004FCompetenzeMW.GetResiduo: String;
begin
  if Assigned(FRiepAss) then
  begin
    Result:=FRiepAss.Residuo;
  end
  else
    Result:='';
end;

function TWR004FCompetenzeMW.GetUnitaDiMisura: String;
begin
  if Assigned(FRiepAss) then
  begin
    Result:=FRiepAss.UMisuraDesc.ToLower;
  end
  else
    Result:='';
end;

function TWR004FCompetenzeMW.GetCompetenze: String;
begin
  if Assigned(FRiepAss) then
  begin
    Result:=FRiepAss.CompTot;
  end
  else
    Result:='';
end;

end.
