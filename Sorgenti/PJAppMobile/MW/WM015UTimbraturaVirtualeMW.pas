unit WM015UTimbraturaVirtualeMW;

interface

uses
  A000UCostanti,
  B110UClientModule,
  B110USharedTypes,
  Data.FireDACJSONReflect,
  FireDAC.Comp.Client,
  System.Generics.Collections,
  System.Sensors, C200UWebServicesTypes, System.SysUtils, System.Classes,
  System.StrUtils, FunzioniGenerali, System.Math, WM015UTimbraturaVirtualeDM,
  A000USessione;
type
  TWM015FTimbraturaVirtualeMW = class(TObject)
  private
    WM015DM: TWM015FTimbraturaVirtualeDM;

    FProgressivo: Integer;
    FTimbCausalizzabile: Boolean;
    FRilevatore: TRilevatore;
    FListaRilevatori: TObjectList<TRilevatore>;
    FListaCausali: TList<TPair<String,String>>;
    FListaTimbrature: TStringList;
    FRilevatoreDefault: TRilevatore;
    FDatiTimbratura: TDatiTimbratura;
    FUsaGeolocalizzazione: Boolean;
    FLatitudineAttuale: Double;
    FLongitudineAttuale: Double;
  public
    constructor Create(PProgressivo: Integer; PTimbCausalizzabile: String; PCodiceRilevatoreMobile: String; PSessioneIrisWin: TSessioneIrisWin);
    destructor Destroy; override;

    property Rilevatore: TRilevatore read FRilevatore write FRilevatore;
    property ListaRilevatori: TObjectList<TRilevatore> read FListaRilevatori;
    property ListaCausali: TList<TPair<String,String>> read FListaCausali;
    property ListaTimbrature: TStringList read FListaTimbrature;
    property UsaGeolocalizzazione: Boolean read FUsaGeolocalizzazione write FUsaGeolocalizzazione;
    property TimbCausalizzabile: Boolean read FTimbCausalizzabile write FTimbCausalizzabile;
    property DatiTimbratura: TDatiTimbratura read FDatiTimbratura write FDatiTimbratura;
    property LatitudineAttuale: Double read FLatitudineAttuale write FLatitudineAttuale;
    property LongitudineAttuale: Double read FLongitudineAttuale write FLongitudineAttuale;

    function CaricaListaRilevatori(PValidazioneTerminali: Boolean): TResCtrl;
    function CaricaListaCausaliSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;
    function CaricaListaTimbratureSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;
    function SetRilevatoreAgganciato(PLatitudine, PLongitudine: Double): Boolean;
    function GetListaRilevatoriJs(const PFmtSettings: TFormatSettings): String;
    function InserisciTimbraturaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl;
    function CreaNuovaTimbratura(POra: TDateTime; PVerso: String; PCodCausale: String): TResCtrl;
    procedure SvuotaRilevatore;
  end;

const
  RILEVATORE_DEFAULT = '--';
  AJAX_CURRENT_POSITION_OK  = 'CurrentPositionOk';
  AJAX_CURRENT_POSITION_ERR = 'CurrentPositionError';

implementation

{ TWM015UTimbraturaVirtualeMW }

constructor TWM015FTimbraturaVirtualeMW.Create(PProgressivo: Integer; PTimbCausalizzabile: String; PCodiceRilevatoreMobile: String; PSessioneIrisWin: TSessioneIrisWin);
begin
  FProgressivo:=PProgressivo;
  FUsaGeolocalizzazione:=False;
  FTimbCausalizzabile:= PTimbCausalizzabile = 'S';
  FListaCausali:=TList<TPair<String,String>>.Create;
  FRilevatoreDefault:=nil;
  // da gestire l'eventuale acquisizione dei dati di questi rilevatori!!!!
  if PCodiceRilevatoreMobile = '' then
    FRilevatore:=TRilevatore.Create('--', '', 0, 0, 0)
  else
    FRilevatore:=TRilevatore.Create(PCodiceRilevatoreMobile, '', 0, 0, 0);

  WM015DM:=TWM015FTimbraturaVirtualeDM.Create(PSessioneIrisWin);

  FListaRilevatori:=TObjectList<TRilevatore>.Create(True);

  FDatiTimbratura:=nil;
  FListaTimbrature:=TStringList.Create;
end;

destructor TWM015FTimbraturaVirtualeMW.Destroy;
begin
  FreeAndNil(WM015DM);
  FreeAndNil(FListaCausali);
  FreeAndNil(FListaTimbrature);
  FreeAndNil(FDatiTimbratura);
  FreeAndNil(FRilevatore);
  FreeAndNil(FRilevatoreDefault);
  FreeAndNil(FListaRilevatori);
  inherited;
end;

function TWM015FTimbraturaVirtualeMW.CreaNuovaTimbratura(POra: TDateTime; PVerso: String; PCodCausale: String): TResCtrl;
begin
  if Assigned(FDatiTimbratura) then
    FreeAndNil(FDatiTimbratura);

  FDatiTimbratura:=TDatiTimbratura.Create;

  // imposta i dati della timbratura
  FDatiTimbratura.EsistonoTolleranze:=False; // nessun parametro di tolleranza viene considerato
  FDatiTimbratura.TimbCausalizzabile:=FTimbCausalizzabile;

  // progressivo
  FDatiTimbratura.Progressivo:=FProgressivo;

  // verso
  FDatiTimbratura.Verso:=PVerso;

  // salva la data/ora
  FDatiTimbratura.DataOra:=POra;
  FDatiTimbratura.Data:=POra.Date;
  FDatiTimbratura.Ora:=POra;

  // causale
  if FDatiTimbratura.TimbCausalizzabile then
    FDatiTimbratura.Causale:=PCodCausale
  else
    FDatiTimbratura.Causale:='';

  // rilevatore
  FDatiTimbratura.Rilevatore:=FRilevatore.Codice;

  // controlli standard dati
  Result:=FDatiTimbratura.Check;
end;

function TWM015FTimbraturaVirtualeMW.GetListaRilevatoriJs(const PFmtSettings: TFormatSettings): String;
var i: Integer;
begin
  Result:='';

  for i := 0 to FListaRilevatori.Count-1 do
  begin
    Result:=Result + FListaRilevatori[i].ToJsObject(PFmtSettings) + ', ';
  end;

  if Result <> '' then
    Result:=Result.Substring(0,Result.Length - 2);
end;

function TWM015FTimbraturaVirtualeMW.SetRilevatoreAgganciato(PLatitudine, PLongitudine: Double): Boolean;
var i: Integer;
    LDist: Integer;
    LDistMin: Integer;
    LRilevatore: TRilevatore;
begin
  LRilevatore:=nil;
  LDistMin:=MAXINT;

  FLatitudineAttuale:=PLatitudine;
  FLongitudineAttuale:=PLongitudine;

  for i:=0 to FListaRilevatori.Count-1 do
  begin
    if FListaRilevatori[i].ContainsLocation(FLatitudineAttuale, FLongitudineAttuale, LDist) then
    begin
      if LDist < LDistMin then
      begin
        LRilevatore:=FListaRilevatori[i];
        LDistMin:=LDist;
      end;
    end;
  end;
  // se non ho trovato un rilevatore ed e' presente quello di default, lo uso
  if (LRilevatore = nil) and (FRilevatoreDefault <> nil) then
      LRilevatore:=FRilevatoreDefault;

  if Assigned(LRilevatore) then
  begin
    if Assigned(FRilevatore) then
      FreeAndNil(FRilevatore);

    FRilevatore:=LRilevatore.Clone;
    Result:=True;
  end
  else
  begin
    if Assigned(FRilevatore) then
      FreeAndNil(FRilevatore);     //se la geolocalizzazione è attivata, se non aggancio un rilevatore non devo poter timbrare
    Result:=False;
  end;
end;

procedure TWM015FTimbraturaVirtualeMW.SvuotaRilevatore;
begin
  FreeAndNil(FRilevatore);
end;

function TWM015FTimbraturaVirtualeMW.InserisciTimbraturaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl;
var LRes: TRisultato;
begin
  // inserimento richiesta server
  LRes:=B110.B110FServerMethodsDMClient.InsTimbratura(InfoClient.PrepareForServer,
                                                      ParametriLogin.PrepareForServer,
                                                      FDatiTimbratura.Clone);

  Result:=LRes.Check(TOutputInsTimbratura);
  if Result.Ok then
    PRisposteMsg:=(LRes.Output as TOutputInsTimbratura).RisposteMsg.Clone
  else
    PRisposteMsg:=nil;
end;

function TWM015FTimbraturaVirtualeMW.CaricaListaCausaliSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;
var fmtT275: TFDMemTable;
    LCausale: TPair<String,String>;
begin
  try
    try
      fmtT275:=TFDMemTable.Create(nil);

      Result:=B110.GetTabellaDizionarioSRV(InfoClient, ParametriLogin, fmtT275, B110_DIZ_TAB_T275_RICHIEDIBILI, '', True);

      if Result.Ok then
      begin
        FListaCausali.Clear;

        fmtT275.First;
        while not fmtT275.Eof do
        begin
          LCausale.Key:=fmtT275.FieldByName('CODICE').AsString;
          LCausale.Value:=fmtT275.FieldByName('DESCRIZIONE').AsString;

          FListaCausali.Add(LCausale);

          fmtT275.Next;
        end;
      end;
    finally
      if Assigned(fmtT275) then
      begin
        if fmtT275.Active then
          fmtT275.Close;

        FreeAndNil(fmtT275);
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

function TWM015FTimbraturaVirtualeMW.CaricaListaTimbratureSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;
var fmtT100: TFDMemTable;
    LRes: TRisultato;
    LDataSetList: TFDJSONDataSets;
    LOra: TDateTime;
    LOraStr: String;
    LVerso: String;
    LCausale: String;
    LRilevatore: String;
    LTimbratura: String;
begin
  LDataSetList:=nil;
  try
    try
      fmtT100:=TFDMemTable.Create(nil);
      // estrae l'elenco delle timbrature
      LRes:=B110.B110FServerMethodsDMClient.Timbrature(InfoClient.PrepareForServer,
                                                       ParametriLogin.PrepareForServer,
                                                       Date,
                                                       Date);
      // verifica risultato
      Result:=LRes.Check(TOutputTimbrature);

      if not Result.Ok then
        Exit
      else
      begin
        //try
          LDataSetList:=(LRes.Output as TOutputTimbrature).JSONDatasets;

          fmtT100.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
          fmtT100.Open;

          FListaTimbrature.Clear;

          fmtT100.First;
          while not fmtT100.Eof do
          begin
            LOra:=fmtT100.FieldByName('ORA').AsDateTime;
            LOraStr:=LOra.ToString('hh.nn');
            LVerso:=fmtT100.FieldByName('VERSO').AsString;
            LCausale:=fmtT100.FieldByName('CAUSALE').AsString;
            LRilevatore:=fmtT100.FieldByName('RILEVATORE').AsString;

            LTimbratura:=Format('%s%s',[LVerso,LOraStr]) + IfThen(LCausale <> '',Format(' (%s)',[LCausale])) + IfThen(LRilevatore <> '',Format(' @%s',[LRilevatore]));

            FListaTimbrature.Add(LTimbratura);
            fmtT100.Next;
          end;
      end;
    finally
      FreeAndNil(LDataSetList);
      if Assigned(fmtT100) then
      begin
        if fmtT100.Active then
          fmtT100.Close;

        FreeAndNil(fmtT100);
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

function TWM015FTimbraturaVirtualeMW.CaricaListaRilevatori(PValidazioneTerminali: Boolean): TResCtrl;
var i: Integer;
begin
  Result.Clear;
  try
    if Assigned(FListaRilevatori) then
      FreeAndNil(FListaRilevatori);
    if Assigned(FRilevatoreDefault) then
      FreeAndNil(FRilevatoreDefault);

    FListaRilevatori:=WM015DM.GetListaRilevatori(FProgressivo, PValidazioneTerminali);

    if FListaRilevatori.Count > 0 then
      FUsaGeolocalizzazione:=True;

    for i:=0 to FListaRilevatori.Count-1 do
    begin
      if FListaRilevatori[i].RaggioValidita = -1 then
        FRilevatoreDefault:=FListaRilevatori[i];  // rilevatore di default
    end;

    if Assigned(FRilevatoreDefault) then
      FListaRilevatori.Extract(FRilevatoreDefault);

    Result.Ok:=True;
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

end.
