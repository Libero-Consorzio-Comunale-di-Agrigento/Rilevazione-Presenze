unit WM012UElencoDipendentiMW;

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

  TWM012FElencoDipendentiMW = class(TWM000FDataSetMW)
    private
      function GetMatricola: String;
      function GetCognome: String;
      function GetNome: String;
      function GetFontColor: Integer;
      function GetCampoSpeciale: Boolean;
    protected
      function GetFieldLabel: String; override;
    public
      constructor Create;
      destructor Destroy; override;

      property Matricola: String read GetMatricola;
      property Cognome: String read GetCognome;
      property Nome: String read GetNome;
      property FontColor: Integer read GetFontColor;

      property CampoSpeciale: Boolean read GetCampoSpeciale;

      function AggiornaDipendentiSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PDataRiferimento: TDateTime): TResCtrl;

      function FirstDettaglio: Boolean;
      function NextDettaglio: Boolean;
      function EofDettaglio: Boolean;

      function LocateMatricola(Matricola: String): Boolean;
  end;

const
    ITEM_MORE_DETAILS = '(...)';

    CAMPI_DA_NASCONDERE  = ',COGNOME,NOME,MATRICOLA,';
    CAMPI_SPECIALI       = ',T030PRESENTE,T030GIUSTIFICATO,T030REPERIBILE,';

implementation

{ TWM012ElencoDipendentiMW }

constructor TWM012FElencoDipendentiMW.Create;
begin
  inherited Create(tdFDMemTable);
end;

destructor TWM012FElencoDipendentiMW.Destroy;
begin
  inherited;
end;

function TWM012FElencoDipendentiMW.FirstDettaglio: Boolean;
var i: Integer;
    LField: TField;
    LNomeCampoRicerca: string;
    LCampoDaNascondere: Boolean;
    LCampoSpeciale: Boolean;
begin
  if not FDMemTable.Active then
    Result:=False
  else if FDMemTable.RecordCount = 0 then
    Result:=False
  else
  begin
    FieldIndex:=0;

    for i:=0 to FDMemTable.FieldCount - 1 do
    begin
      LField:=FDMemTable.Fields[i];

      LNomeCampoRicerca:=Format(',%s,',[LField.Origin.ToUpper]);
      LCampoDaNascondere:=CAMPI_DA_NASCONDERE.IndexOf(LNomeCampoRicerca) >= 0;
      LCampoSpeciale:=CAMPI_SPECIALI.IndexOf(LNomeCampoRicerca) >= 0;

      if (not LCampoDaNascondere) and
         (LField.Visible or (LCampoSpeciale and not LField.IsNull)) then
      begin
        FieldIndex:=i;
        Result:=True;
        Exit;
      end;
    end;

    Result:=False;
  end;
end;

function TWM012FElencoDipendentiMW.NextDettaglio: Boolean;
var i: Integer;
    LField: TField;
    LNomeCampoRicerca: string;
    LCampoDaNascondere: Boolean;
    LCampoSpeciale: Boolean;
begin
  if not FDMemTable.Active then
    Result:=False
  else if FDMemTable.RecordCount = 0 then
    Result:=False
  else if FieldIndex = FDMemTable.FieldCount - 1 then
    Result:=False
  else
  begin
    for i:=FieldIndex+1 to FDMemTable.FieldCount - 1 do
    begin
      LField:=FDMemTable.Fields[i];

      LNomeCampoRicerca:=Format(',%s,',[LField.Origin.ToUpper]);
      LCampoDaNascondere:=CAMPI_DA_NASCONDERE.IndexOf(LNomeCampoRicerca) >= 0;
      LCampoSpeciale:=CAMPI_SPECIALI.IndexOf(LNomeCampoRicerca) >= 0;

      if (not LCampoDaNascondere) and
         (LField.Visible or (LCampoSpeciale and not LField.IsNull)) then
      begin
        FieldIndex:=i;
        Result:=True;
        Exit;
      end;
    end;

    FieldIndex:=i;
    Result:=False;
  end;
end;

function TWM012FElencoDipendentiMW.EofDettaglio: Boolean;
var i: Integer;
    LField: TField;
    LNomeCampoRicerca: string;
    LCampoDaNascondere: Boolean;
    LCampoSpeciale: Boolean;
begin
  if not FDMemTable.Active then
    Result:=True
  else if FDMemTable.RecordCount = 0 then
    Result:=True
  else if FieldIndex = FDMemTable.FieldCount - 1 then
    Result:=True
  else
  begin
    for i:=FieldIndex to FDMemTable.FieldCount-1 do
    begin
      LField:=FDMemTable.Fields[i];

      LNomeCampoRicerca:=Format(',%s,',[LField.Origin.ToUpper]);
      LCampoDaNascondere:=CAMPI_DA_NASCONDERE.IndexOf(LNomeCampoRicerca) >= 0;
      LCampoSpeciale:=CAMPI_SPECIALI.IndexOf(LNomeCampoRicerca) >= 0;

      if (not LCampoDaNascondere) and
         (LField.Visible or (LCampoSpeciale and not LField.IsNull)) then
      begin
        Result:=False;
        Exit;
      end;
    end;

    Result:=True;
  end;
end;

function TWM012FElencoDipendentiMW.LocateMatricola(Matricola: String): Boolean;
begin
  if FDMemTable.Active then
    Result:=FDMemTable.Locate('MATRICOLA', Matricola)
  else
    Result:=False;
end;

function TWM012FElencoDipendentiMW.GetMatricola: String;
begin
  if not FDMemTable.Active then
    Result:=''
  else
    Result:=FDMemTable.FieldByName('MATRICOLA').AsString;
end;

function TWM012FElencoDipendentiMW.GetCampoSpeciale: Boolean;
var LField: TField;
    LNomeCampoRicerca: string;
begin
  if not FDMemTable.Active then
    Result:=False
  else if FDMemTable.RecordCount = 0 then
    Result:=False
  else
  begin
    LField:=FDMemTable.Fields[FieldIndex];
    LNomeCampoRicerca:=Format(',%s,',[LField.Origin.ToUpper]);
    Result:=CAMPI_SPECIALI.IndexOf(LNomeCampoRicerca) >= 0;
  end;
end;

function TWM012FElencoDipendentiMW.GetCognome: String;
begin
  if not FDMemTable.Active then
    Result:=''
  else
    Result:=FDMemTable.FieldByName('COGNOME').AsString;
end;

function TWM012FElencoDipendentiMW.GetNome: String;
begin
  if not FDMemTable.Active then
    Result:=''
  else
    Result:=FDMemTable.FieldByName('NOME').AsString;
end;

function TWM012FElencoDipendentiMW.GetFontColor: Integer;
var LDipInServizio: Boolean;
    LDipGiustificato: Boolean;
    LDipReperibile: Boolean;
begin
  if not FDMemTable.Active then
    Result:=FONT_COLOR_DEFAULT
  else
  begin
    LDipInServizio:=not FDMemTable.FieldByName('T030PRESENTE').IsNull;
    LDipGiustificato:=not FDMemTable.FieldByName('T030GIUSTIFICATO').IsNull;
    LDipReperibile:=not FDMemTable.FieldByName('T030REPERIBILE').IsNull;

    if LDipInServizio then
      Result:=FONT_COLOR_DIP_IN_SERVIZIO
    else if LDipGiustificato then
      Result:=FONT_COLOR_DIP_GIUSTIFICATO
    else if LDipReperibile then
      Result:=FONT_COLOR_DIP_REPERIBILE
    else
      Result:=FONT_COLOR_DEFAULT;
  end;
end;

function TWM012FElencoDipendentiMW.GetFieldLabel: String;
begin
  if FDMemTable.Active then
    Result:=FDMemTable.Fields[FieldIndex].DisplayLabel.Substring(0,1).ToUpper + FDMemTable.Fields[FieldIndex].DisplayLabel.Substring(1).ToLower
  else
    Result:='';
end;

function TWM012FElencoDipendentiMW.AggiornaDipendentiSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PDataRiferimento: TDateTime): TResCtrl;
var
  LRes: TRisultato;
  LDataSetList: TFDJSONDataSets;
  VisibleFields:String;
  DisplayLabels:String;
begin
  try
    FDMemTable.Close;
    // estrae l'elenco dei dipendenti
    LRes:=B110.B110FServerMethodsDMClient.Dipendenti(InfoClient.PrepareForServer,
                                                     ParametriLogin.PrepareForServer,
                                                     PDataRiferimento,
                                                     '');
    // verifica risultato
    Result:=LRes.Check(TOutputElencoDipendenti);
    if Result.Ok then
    begin
      try
        LDataSetList:=(LRes.Output as TOutputElencoDipendenti).JSONDatasets;
        VisibleFields:=(LRes.Output as TOutputElencoDipendenti).VisibleFields;
        DisplayLabels:=(LRes.Output as TOutputElencoDipendenti).DisplayLabels;
        FDMemTable.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
        FDMemTable.SetFields(VisibleFields,DisplayLabels);
        FDMemTable.Open;
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

end.
