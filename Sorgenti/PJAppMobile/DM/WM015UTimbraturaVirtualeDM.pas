unit WM015UTimbraturaVirtualeDM;

interface

uses
  System.SysUtils, System.Classes, WM000UDataModuleBaseDM, Data.DB, OracleData,
  System.Generics.Collections, System.Sensors, System.Math, A000USessione, StrUtils;
type

  TRilevatore = class(TObject)
    private
      FCodice: String;
      FDescrizione: String;
      FCentro: TLocationCoord2D;
      FRaggioValidita: TLocationDistance;
    public
      constructor Create; overload;
      constructor Create(PCodice, PDescrizione: String; PLatitudine, PLongitudine: Double; PRaggioValidita: Double); overload;
      destructor Destroy; override;

      property Codice: String read FCodice;
      property Descrizione: String read FDescrizione;
      property RaggioValidita: TLocationDistance read FRaggioValidita;

      function ToJsObject(const PFmtSettings: TFormatSettings): String;
      function GetDistanceFromCoords(PTarget: TLocationCoord2D): Integer;
      function ContainsLocation(PLatitudine, PLongitudine: Double; var RDistanceFromCenter: Integer): Boolean;
      function Clone: TRilevatore;
  end;

  TWM015FTimbraturaVirtualeDM = class(TWM000FDataModuleBaseDM)
    selT361: TOracleDataSet;
    selT430: TOracleDataSet;
    procedure selT361FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    function GetTerminaliAbilitati(PProgressivo: Integer): TStringList;
    function ValidaTerminale(PCodTerminale: String; PListaTerminali: TStringList): Boolean;
  public
    function GetListaRilevatori(PProgressivo: Integer; PValidazioneTerminali: Boolean): TObjectList<TRilevatore>;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TWM015FTimbraturaVirtualeDM.GetListaRilevatori(PProgressivo: Integer; PValidazioneTerminali: Boolean): TObjectList<TRilevatore>;
var
  LCodice: String;
  LDescrizione: String;
  LLatitudine: Double;
  LLongitudine: Double;
  LRaggioValidita: Integer;
  LTerminaliAbilitati: TStringList;
begin
  //selT361FilterRecord applica il filtro dizionario
  Result:=TObjectList<TRilevatore>.Create(True);
  LTerminaliAbilitati:=nil;

  if PValidazioneTerminali then  //se è richiesta la validazione dei terminali
    LTerminaliAbilitati:=GetTerminaliAbilitati(PProgressivo);
  try
    with selT361 do
    begin
      Close;
      Filtered:=True;
      Open;

      First;
      while not Eof do
      begin
        LCodice:=FieldByName('CODICE').AsString;
        LDescrizione:=FieldByName('DESCRIZIONE').AsString;
        LLatitudine:=FieldByName('LAT').AsFloat;
        LLongitudine:=FieldByName('LNG').AsFloat;
        LRaggioValidita:=FieldByName('RAGGIO_VALIDITA').AsInteger;

        if PValidazioneTerminali then //se è richiesta la validazione dei terminali
        begin
          if ValidaTerminale(LCodice, LTerminaliAbilitati) then
            Result.Add(TRilevatore.Create(LCodice, LDescrizione, LLatitudine, LLongitudine, LRaggioValidita));
        end
        else
          Result.Add(TRilevatore.Create(LCodice, LDescrizione, LLatitudine, LLongitudine, LRaggioValidita));

        Next;
      end;
      Close;
    end;
  finally
    FreeAndNil(LTerminaliAbilitati);
  end;
end;

function TWM015FTimbraturaVirtualeDM.GetTerminaliAbilitati(PProgressivo: Integer): TStringList;
begin
  Result:=TStringList.Create;
  try
    with selT430 do
    begin
      Close;
      SetVariable('PROGRESSIVO', PProgressivo);
      Open;

      if FieldByName('TERMINALI').AsString.Trim <> '' then
      begin
        Result.StrictDelimiter:=True;
        Result.Delimiter:=',';
        Result.DelimitedText:=FieldByName('TERMINALI').AsString.Trim;
      end;
      Close;
    end;
  except
    on E: Exception do
    begin
      FreeAndNil(Result);
      raise;
    end;
  end;
end;

function TWM015FTimbraturaVirtualeDM.ValidaTerminale(PCodTerminale: String; PListaTerminali: TStringList): Boolean;
var i: Integer;
begin
  Result:=False;
  //se sono presenti dei terminali nella lista applico il filtro
  if PListaTerminali.Count > 0 then
  begin
    for i:=0 to PListaTerminali.Count-1 do
    begin
      if PListaTerminali[i].Trim = PCodTerminale then
      begin
        Result:=True;
        break;
      end;
    end;
  end
  else
    Result:=True;
end;

procedure TWM015FTimbraturaVirtualeDM.selT361FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('OROLOGI DI TIMBRATURA', DataSet.FieldByName('CODICE').AsString);
end;

{ TRilevatore }

constructor TRilevatore.Create;
begin
  inherited Create;
end;

constructor TRilevatore.Create(PCodice, PDescrizione: String; PLatitudine, PLongitudine, PRaggioValidita: Double);
begin
  FCodice:=PCodice;
  FDescrizione:=PDescrizione;
  FCentro:=TLocationCoord2D.Create(PLatitudine, PLongitudine);
  FRaggioValidita:=PRaggioValidita;
end;

destructor TRilevatore.Destroy;
begin
  inherited;
end;

function TRilevatore.GetDistanceFromCoords(PTarget: TLocationCoord2D): Integer;
var
  LDeltaLngRad: double;
  LDeltaLatRad: double;
  a: double;
  c: double;
  LDist: double;
const
  RAGGIO_EQUATORIALE_KM = 6378.1370; // in km
begin
  // coordinate in radianti
  LDeltaLngRad:=DegToRad(PTarget.Longitude - FCentro.Longitude);
  LDeltaLatRad:=DegToRad(PTarget.Latitude - FCentro.Latitude);

  a:=Power(Sin(LDeltaLatRad / 2), 2) + Cos(DegToRad(FCentro.Latitude)) * Cos(DegToRad(PTarget.Latitude)) * Power(Sin(LDeltaLngRad / 2), 2);
  c:=2 * ArcTan2(Sqrt(a), Sqrt(1 - a));
  LDist:=RAGGIO_EQUATORIALE_KM * c;

  // il risultato (ora in km) viene espresso in metri
  Result:=Trunc(LDist * 1000);
end;

function TRilevatore.Clone: TRilevatore;
begin
  Result:=TRilevatore.Create;
  Result.FCodice:=FCodice;
  Result.FDescrizione:=FDescrizione;
  Result.FCentro:=FCentro;
  Result.FRaggioValidita:=FRaggioValidita;
end;

function TRilevatore.ContainsLocation(PLatitudine, PLongitudine: Double; var RDistanceFromCenter: Integer): Boolean;
var LCoord2D: TLocationCoord2D;
begin
  if FRaggioValidita = -1 then
  begin
    RDistanceFromCenter:=-1;
    Result:=True;
  end
  else
  begin
    LCoord2D:=TLocationCoord2D.Create(PLatitudine,PLongitudine);

    RDistanceFromCenter:=GetDistanceFromCoords(LCoord2D);
    Result:=RDistanceFromCenter <= FRaggioValidita;
  end;
end;

function TRilevatore.ToJsObject(const PFmtSettings: TFormatSettings): String;
begin
   Result:=Format(
      '"%s": { "center": { "lat": %s, "lng": %s }, "radius": %d }',
      [FCodice.Replace('"','\"',[rfReplaceAll]),
       Format('%2.6f', [FCentro.Latitude], PFmtSettings).Replace(',','.',[]),
       Format('%2.6f', [FCentro.Longitude], PFmtSettings).Replace(',','.',[]),
       Trunc(FRaggioValidita)]
    );
end;

end.
