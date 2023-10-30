unit WR005UTimbratureModificabiliMW;

interface

uses
  A000UCostanti,
  B110UClientModule,
  B110USharedTypes,
  Data.FireDACJSONReflect,
  FireDAC.Comp.Client,
  System.Generics.Collections,
  System.Sensors, C200UWebServicesTypes, C200UWebServicesUtils, System.SysUtils, System.Classes,
  System.StrUtils, FunzioniGenerali, System.Math, WM000UConstants, Data.DB, WM000UDataSetMW;

type

  TWR005FTimbratureModificabiliMW = class(TWM000FDataSetMW)
    private
      function GetId: String;
      function GetNominativo: String;
      function GetOra: String;
      function GetCausale: String;
      function GetDescCausale: String;
      function GetVerso: String;
      function GetDescVerso: String;
      function GetFlag: String;
      function GetRilevatore: String;
      function GetData: TDateTime;
    protected

    public
      constructor Create;

      property Id: String read GetId;
      property Nominativo: String read GetNominativo;
      property Data: TDateTime read GetData;
      property Ora: String read GetOra;
      property Causale: String read GetCausale;
      property DescCausale: String read GetDescCausale;
      property Verso: String read GetVerso;
      property DescVerso: String read GetDescVerso;
      property Flag: String read GetFlag;
      property Rilevatore: String read GetRilevatore;

      function AggiornaTimbratureModifSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PData: TDateTime): TResCtrl;
      function DatiTimbraturaChanged(POra, PVerso, PCodCausale, PCodRilevatore: String): Boolean;
  end;

implementation

{ TWM014FTimbratureModificabiliMW }

constructor TWR005FTimbratureModificabiliMW.Create;
begin
  inherited Create(tdFDMemTable);
end;

function TWR005FTimbratureModificabiliMW.AggiornaTimbratureModifSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PData: TDateTime): TResCtrl;
var
  LRes: TRisultato;
  LDataSetList: TFDJSONDataSets;
begin
  try
    FDataSet.Close;

    // estrae l'elenco delle timbrature modificabili alla data indicata
    LRes:=B110.B110FServerMethodsDMClient.TimbModificabili(InfoClient.PrepareForServer,
                                                           ParametriLogin.PrepareForServer,
                                                           PData,
                                                           '');
    Result:=LRes.Check(TOutputTimbModificabili);
    if Result.Ok then     // risposta servizio ok
    begin
      try
        LDataSetList:=(LRes.Output as TOutputTimbModificabili).JSONDatasets;

        // elenco richieste
        FDMemTable.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));

        FDataSet.First;
      finally
        FreeAndNil(LDataSetList);
      end;
    end;
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

function TWR005FTimbratureModificabiliMW.DatiTimbraturaChanged(POra, PVerso, PCodCausale, PCodRilevatore: String): Boolean;
begin
  if Ora <> POra then
    Result:=True
  else if Verso <> PVerso then
    Result:=True
  else if Causale <> PCodCausale then
    Result:=True
  else if Rilevatore <> PCodRilevatore then
    Result:=True
  else
    Result:=False;
end;

function TWR005FTimbratureModificabiliMW.GetId: String;
begin
  if FDataSet.Active then
    Result:=FDataSet.FieldByName('ID').AsString
  else
    Result:='';
end;

function TWR005FTimbratureModificabiliMW.GetNominativo: String;
begin
  if FDataSet.Active then
    Result:=FDataSet.FieldByName('NOMINATIVO').AsString
  else
    Result:='';
end;

function TWR005FTimbratureModificabiliMW.GetOra: String;
begin
  if FDataSet.Active then
    Result:=FDataSet.FieldByName('ORA').AsString
  else
    Result:='';
end;

function TWR005FTimbratureModificabiliMW.GetCausale: String;
begin
  if FDataSet.Active then
    Result:=FDataSet.FieldByName('CAUSALE').AsString
  else
    Result:='';
end;

function TWR005FTimbratureModificabiliMW.GetData: TDateTime;
begin
  if FDataSet.Active then
    Result:=FDataSet.FieldByName('DATA').AsDateTime
  else
    Result:=DATE_MAX;
end;

function TWR005FTimbratureModificabiliMW.GetDescCausale: String;
begin
  if FDataSet.Active then
    Result:=FDataSet.FieldByName('DESC_CAUSALE').AsString
  else
    Result:='';
end;

function TWR005FTimbratureModificabiliMW.GetVerso: String;
begin
  if FDataSet.Active then
    Result:=FDataSet.FieldByName('VERSO').AsString
  else
    Result:='';
end;

function TWR005FTimbratureModificabiliMW.GetDescVerso: String;
begin
  if FDataSet.Active then
    Result:=FDataSet.FieldByName('DESC_VERSO').AsString
  else
    Result:='';
end;

function TWR005FTimbratureModificabiliMW.GetFlag: String;
begin
  if FDataSet.Active then
    Result:=FDataSet.FieldByName('FLAG').AsString
  else
    Result:='';
end;

function TWR005FTimbratureModificabiliMW.GetRilevatore: String;
begin
  if FDataSet.Active then
    Result:=FDataSet.FieldByName('RILEVATORE').AsString
  else
    Result:='';
end;

end.
