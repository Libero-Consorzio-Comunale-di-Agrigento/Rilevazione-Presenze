unit WM005UCedolinoMW;

interface

uses
  A000UCostanti,
  A000Versione,
  B110USharedTypes,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  B110UClientModule,
  SysUtils,
  Classes,
  System.IOUtils,
  System.Types,
  System.Math,
  FireDAC.Comp.Client, Data.FireDACJSONReflect, DateUtils, FunzioniGenerali, Generics.Collections, WM000UConstants;

type
  TDatiCedolino = class(TObject)
    private
      FID: Integer;
      FDataRetribuzione: String;
      FLblDataRetribuzione: String;
      FLblImporto: String;
      FTipoCedolino: String;
      FDataCedolino: String;
      FLblDataCedolino: String;

    public
      property ID: Integer read FID;
      property DataRetribuzione: String read FDataRetribuzione;
      property LblDataRetribuzione: String read FLblDataRetribuzione;
      property LblImporto: String read FLblImporto;
      property TipoCedolino: String read FTipoCedolino;
      property DataCedolino: String read FDataCedolino;
      property LblDataCedolino: String read FLblDataCedolino;
  end;

  TWM005FCedolinoMW = class(TObject)
    private
      FDMemTableCedolini: TFDMemTable;

      FCumuloVociArretrate: Boolean;
      FStampaOrigineVoci: Boolean;

      FMeseMin: TDateTime;
      FMeseMax: TDateTime;
      FMeseDa: TDateTime;
      FMeseA: TDateTime;

      procedure CaricaDateIniziali(WEBCedoliniDataMin: TDateTime; WEBCedoliniMMPrec: Integer);
      function StampaCedolinoPdfSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin;
                                                      PIdCedolino: Integer; var RAzioneCedolino: TAzioneCedolino; var RMeseCedolino: TDateTime;
                                                      var RPdfWrapper: TByteDynArrayWrapper): TResCtrl;
    public
      property MeseDa: TDateTime read FMeseDa;
      property MeseA: TDateTime read FMeseA;

      constructor Create(WEBCedoliniDataMin: TDateTime; WEBCedoliniMMPrec: Integer; PCumuloVociArretrate: boolean = true; PStampaOrigineVoci: boolean = false);
      destructor Destroy; override;

      function NumCedolini: Integer;
      function StringaNumCedolini: String;
      function GetListaCedolini: TObjectList<TDatiCedolino>;
      function ControllaDate(PMeseDa, PMeseA: TDateTime): TResCtrl;
      function AggiornaListaCedoliniSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;
      function StampaCedolinoPdf(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PIdCedolino: Integer; PPathFilePdf: String; var RAzioneCedolino: TAzioneCedolino; var RMeseCedolino: TDateTime) : TResCtrl;
      function ImpostaDataConsegnaCedolinoSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; const PIdCedolino: Integer): TResCtrl;
  end;

const
  MESI_DA_VISUALIZZARE   = 13;

implementation

{ TWM005UCedoliniMW }

constructor TWM005FCedolinoMW.Create(WEBCedoliniDataMin: TDateTime; WEBCedoliniMMPrec: Integer; PCumuloVociArretrate, PStampaOrigineVoci: boolean);
begin
  inherited Create;
  FDMemTableCedolini:=TFDMemTable.Create(nil);

  FCumuloVociArretrate:=PCumuloVociArretrate;
  FStampaOrigineVoci:=PStampaOrigineVoci;

  CaricaDateIniziali(WEBCedoliniDataMin, WEBCedoliniMMPrec);
end;

destructor TWM005FCedolinoMW.Destroy;
begin
  if Assigned(FDMemTableCedolini) then
    if FDMemTableCedolini.Active then
      FDMemTableCedolini.Close;

  FreeAndNil(FDMemTableCedolini);
  inherited;
end;

procedure TWM005FCedolinoMW.CaricaDateIniziali(WEBCedoliniDataMin: TDateTime; WEBCedoliniMMPrec: Integer);
var
  LDataCorrente: TDateTime;
begin
  LDataCorrente:=Now;
  // determina la data minima per la stampa
  // la più recente fra:
  //   data min. per stampa cedolini
  //   13 mesi fa
  //   WEBCedoliniMMPrec mesi fa
  FMeseMin:=WEBCedoliniDataMin;
  FMeseMin:=Max(FMeseMin,LDataCorrente.StartOfMonth.AddMonths(- MESI_DA_VISUALIZZARE + 1));
  if WEBCedoliniMMPrec >= 0 then
    FMeseMin:=Max(FMeseMin,FMeseMin.StartOfMonth.AddMonths(-WEBCedoliniMMPrec));

  // determina la data massima per la stampa
  FMeseMax:=LDataCorrente;

  // i mesi sono considerati all'ultimo giorno
  FMeseMin:=FMeseMin.EndOfMonth.Date;
  FMeseMax:=FMeseMax.EndOfMonth.Date;

  // ultimi n mesi compresa la data corrente
  FMeseA:=LDataCorrente;
  FMeseDa:=IncMonth(FMeseA,(- MESI_DA_VISUALIZZARE + 1));

  // i mesi sono considerati all'ultimo giorno
  FMeseDa:=FMeseDa.EndOfMonth.Date;
  FMeseA:=FMeseA.EndOfMonth.Date;
end;

function TWM005FCedolinoMW.ControllaDate(PMeseDa, PMeseA: TDateTime): TResCtrl;
begin
  Result.Clear;

  // i mesi sono considerati all'ultimo giorno
  FMeseDa:=PMeseDa.EndOfMonth.Date;
  FMeseA:=PMeseA.EndOfMonth.Date;

  // range mesi di stampa
  if (FMeseDa < FMeseMin) or
     (FMeseA > FMeseMax) then
  begin
    Result.Messaggio:=Format('Periodo di ricerca esterno al range disponibile'#13#10'(%s - %s)',
                             [FMeseMin.ToString('mmmm yyyy'),FMeseMax.ToString('mmmm yyyy')]);
    Exit;
  end;

  if FMeseA < FMeseDa then
  begin
    Result.Messaggio:=Format('Periodo di ricerca non valido'#13#10'(%s - %s)',
                             [FMeseDa.ToString('mmmm yyyy'),FMeseA.ToString('mmmm yyyy')]);
    Exit;
  end;

  // controlli ok
  Result.Ok:=True;
end;

function TWM005FCedolinoMW.GetListaCedolini: TObjectList<TDatiCedolino>;
var LDatiCedolino : TDatiCedolino;
begin
  Result:= TObjectList<TDatiCedolino>.Create;

  if not FDMemTableCedolini.Active then
    Exit;

  FDMemTableCedolini.First;
  while not FDMemTableCedolini.Eof do
  begin
    LDatiCedolino:= TDatiCedolino.Create;

    LDatiCedolino.FID:=FDMemTableCedolini.FieldByName('ID_CEDOLINO').AsInteger;
    LDatiCedolino.FDataRetribuzione:=FDMemTableCedolini.FieldByName('DATA_RETRIBUZIONE').AsString;
    LDatiCedolino.FLblDataRetribuzione:=FDMemTableCedolini.FieldByName('LBL_DATA_RETRIBUZIONE').AsString;
    LDatiCedolino.FLblImporto:=FDMemTableCedolini.FieldByName('LBL_IMPORTO').AsString;
    LDatiCedolino.FTipoCedolino:=FDMemTableCedolini.FieldByName('TIPO_CEDOLINO').AsString;
    LDatiCedolino.FDataCedolino:=FDMemTableCedolini.FieldByName('DATA_CEDOLINO').AsString;
    LDatiCedolino.FLblDataCedolino:=FDMemTableCedolini.FieldByName('LBL_DATA_CEDOLINO').AsString;

    Result.Add(LDatiCedolino);

    FDMemTableCedolini.Next;
  end;

  FDMemTableCedolini.First;
end;

function TWM005FCedolinoMW.NumCedolini: Integer;
begin
  if Assigned(FDMemTableCedolini) then
    Result:=FDMemTableCedolini.RecordCount
  else
    Result:=0;
end;

function TWM005FCedolinoMW.StringaNumCedolini: String;
var num: Integer;
begin
  num:= NumCedolini;

  if num = 0 then
    Result:='Nessun cedolino'
  else if num = 1 then
    Result:='1 cedolino'
  else
    Result:=Format('%d cedolini',[num]);
end;

function TWM005FCedolinoMW.AggiornaListaCedoliniSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;
var
  LRes: TRisultato;
  LDataSetList: TFDJSONDataSets;
begin
  if not Assigned(B110) or not Assigned(Infoclient) or not Assigned(ParametriLogin) then
  begin
    Result.Ok:=False;
    Result.Messaggio:='Impossibile aggiornare la lista dei cedolini, parametri incompleti';
    Exit;
  end;
  try
    FDMemTableCedolini.Close;

    // estrae dataset cedolini
    LRes:=B110.B110FServerMethodsDMClient.Cedolini(InfoClient.PrepareForServer,
                                                     ParametriLogin.PrepareForServer,
                                                     False,
                                                     FMeseDa,
                                                     FMeseA
                                                    );
    // verifica risultato
    Result:=LRes.Check(TOutputCedolini);
    if Result.Ok then
    begin
      // prepara dataset cedolini
      try
        LDataSetList:=(LRes.Output as TOutputCedolini).JSONDatasets;
        FDMemTableCedolini.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
        FDMemTableCedolini.Open;
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

function TWM005FCedolinoMW.ImpostaDataConsegnaCedolinoSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; const PIdCedolino: Integer): TResCtrl;
var
  LRes: TRisultato;
begin
  try
    // imposta la data di consegna del cedolino
    LRes:=B110.B110FServerMethodsDMClient
            .ImpostaDataConsegnaCedolino(InfoClient.PrepareForServer,
                                         ParametriLogin.PrepareForServer,
                                         PIdCedolino);
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

function TWM005FCedolinoMW.StampaCedolinoPdfSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin;
  PIdCedolino: Integer; var RAzioneCedolino: TAzioneCedolino; var RMeseCedolino: TDateTime; var RPdfWrapper: TByteDynArrayWrapper): TResCtrl;
// genera il cedolino pdf richiesto
var
  LRes: TRisultato;
  LOutput: TOutputStampaCedolino;
  LPdfWrapper: TByteDynArrayWrapper;
begin
  // estrae il cedolino pdf generato dal server
  LRes:=B110.B110FServerMethodsDMClient.Cedolino(InfoClient.PrepareForServer,
                                                  ParametriLogin.PrepareForServer,
                                                  PIdCedolino,
                                                  FCumuloVociArretrate,
                                                  FStampaOrigineVoci);
  // verifica risultato
  Result:=LRes.Check(TOutputStampaCedolino);
  if Result.Ok then
  begin
    try
      LOutput:=(LRes.Output as TOutputStampaCedolino);

      // utilizza classe wrapper specifica
      LPdfWrapper:=(LOutput.FileCedolino as TByteDynArrayWrapper);
      if LPdfWrapper = nil then
        RPdfWrapper:=nil
      else
        RPdfWrapper:=LPdfWrapper.Clone;

      // restituisce alcuni dati di output per l'azione da intraprendere successivamente
      RAzioneCedolino:=LOutput.Azione;
      RMeseCedolino:=LOutput.MeseCedolino;
    except
      on E: Exception do
      begin
        Result.Messaggio:='Errore durante la generazione del cedolino PDF: ' + E.Message;
        Exit;
      end;
    end;
  end;
end;

function TWM005FCedolinoMW.StampaCedolinoPdf(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PIdCedolino: Integer; PPathFilePdf: String; var RAzioneCedolino: TAzioneCedolino; var RMeseCedolino: TDateTime) : TResCtrl;
var
  LPdfWrapper: TByteDynArrayWrapper;
  LByteArrPdf: TByteDynArray;
begin
  if not Assigned(B110) or not Assigned(Infoclient) or not Assigned(ParametriLogin) then
  begin
    Result.Ok:=False;
    Result.Messaggio:='Impossibile stampare il cedolino, parametri incompleti';
    Exit;
  end;

  LPdfWrapper:=nil;
  Result:=StampaCedolinoPdfSRV(B110, InfoClient, ParametriLogin, PIdCedolino, RAzioneCedolino, RMeseCedolino, LPdfWrapper);

  if Result.Ok then
  begin
    try
      if LPdfWrapper <> nil then
      begin
        LByteArrPdf:=LPdfWrapper.Value;
        TC200FWebServicesUtils.ByteArrayToFile(LByteArrPdf,PPathFilePdf);
      end;
    finally
      FreeAndNil(LPdfWrapper);
    end;
  end;
end;

end.
