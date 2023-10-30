unit WM004UCartellinoMW;

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
  FireDAC.Comp.Client, Data.FireDACJSONReflect, DateUtils, FunzioniGenerali,
  Generics.Collections;

type
  TWM004FCartellinoMW = class(TObject)
    private
      FProfili: TList<TPair<String, String>>;
      FDMemTableCartellini: TFDMemTable;

      FMeseMin: TDateTime;
      FMeseMax: TDateTime;
      FMeseDa: TDateTime;
      FMeseA: TDateTime;

      procedure CaricaParamStampa(PCodiciT950: TNomeValoreArr);
      procedure CaricaDateIniziali(PWEBCartelliniDataMin: TDateTime; PWEBCartelliniMMPrec, PWEBCartelliniMMSucc : Integer);
      function StampaCartellinoPdfSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PMese: TDateTime; PCodParamStampa: String; var RPdfWrapper: TByteDynArrayWrapper): TResCtrl;
    public
      property Profili : TList<TPair<String, String>> read FProfili;
      property MeseDa : TDateTime read FMeseDa;
      property MeseA : TDateTime read FMeseA;

      constructor Create(PCodiciT950: TNomeValoreArr; PWEBCartelliniDataMin: TDateTime; PWEBCartelliniMMPrec, PWEBCartelliniMMSucc : Integer);
      destructor Destroy; override;

      function NumCartellini: Integer;
      function StringaNumCartellini: String;
      function GetListaCartellini: TStringList;
      function ControllaDate(PMeseDa, PMeseA: TDateTime): TResCtrl;
      function AggiornaListaCartelliniSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;
      function StampaCartellinoPdf(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PMese: String; PCodParStampa: String; PPathFilePdf: String) : TResCtrl;
  end;

const
  MESI_DA_VISUALIZZARE   = 13;

implementation

{ TWM004FCartellinoMW }

constructor TWM004FCartellinoMW.Create(PCodiciT950: TNomeValoreArr; PWEBCartelliniDataMin: TDateTime; PWEBCartelliniMMPrec, PWEBCartelliniMMSucc : Integer);
begin
  inherited Create;
  FProfili:=TList<TPair<String, String>>.Create;
  FDMemTableCartellini:=TFDMemTable.Create(nil);

  CaricaParamStampa(PCodiciT950);
  CaricaDateIniziali(PWEBCartelliniDataMin, PWEBCartelliniMMPrec, PWEBCartelliniMMSucc);
end;

destructor TWM004FCartellinoMW.Destroy;
begin
  FreeAndNil(FProfili);

  if Assigned(FDMemTableCartellini) then
    if FDMemTableCartellini.Active then
      FDMemTableCartellini.Close;

  FreeAndNil(FDMemTableCartellini);

  inherited;
end;

procedure TWM004FCartellinoMW.CaricaParamStampa(PCodiciT950: TNomeValoreArr);
var i: Integer;
begin
  FProfili.Clear;
  for i:=Low(PCodiciT950) to High(PCodiciT950) do
    // ogni elemento contiene nome (codice) e valore (descrizione)
    FProfili.Add(TPair<String, String>.Create(PCodiciT950[i].Nome,PCodiciT950[i].Valore));
end;

procedure TWM004FCartellinoMW.CaricaDateIniziali(PWEBCartelliniDataMin: TDateTime; PWEBCartelliniMMPrec, PWEBCartelliniMMSucc: Integer);
var LDataCorrente: TDateTime;
begin
  LDataCorrente:=Now;

  // determina la data minima per la stampa
  FMeseMin:=PWEBCartelliniDataMin;
  FMeseMin:=Max(FMeseMin,LDataCorrente.StartOfMonth.AddMonths(- MESI_DA_VISUALIZZARE + 1));
  if PWEBCartelliniMMPrec >= 0 then
    FMeseMin:=Max(FMeseMin,FMeseMin.StartOfMonth.AddMonths(-PWEBCartelliniMMPrec));

  // determina la data massima per la stampa
  FMeseMax:=DATE_MAX;
  if PWEBCartelliniMMSucc >= 0 then
    FMeseMax:=LDataCorrente.StartOfMonth.AddMonths(PWEBCartelliniMMSucc);

  // imposta le date calcolate
  FMeseDa:=FMeseMin.StartOfMonth;
  FMeseA:=LDataCorrente.StartOfMonth;
end;

function TWM004FCartellinoMW.StampaCartellinoPdfSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PMese: TDateTime; PCodParamStampa: String; var RPdfWrapper: TByteDynArrayWrapper): TResCtrl;
// genera il cartellino pdf richiesto
var
  LRes: TRisultato;
  LPdfWrapper: TByteDynArrayWrapper;
begin
  try
    // estrae il cartellino pdf generato dal server
    LRes:=B110.B110FServerMethodsDMClient
            .Cartellino(InfoClient.PrepareForServer,
                        ParametriLogin.PrepareForServer,
                        PMese,
                        PCodParamStampa
                        );

    // verifica risultato
    Result:=LRes.Check(TByteDynArrayWrapper);
    if not Result.Ok then
      Exit;

    // utilizza classe wrapper specifica
    LPdfWrapper:=(LRes.Output as TByteDynArrayWrapper);
    if LPdfWrapper = nil then
      RPdfWrapper:=nil
    else
      RPdfWrapper:=LPdfWrapper.Clone;
    // operazione ok
    Result.Ok:=True;
  except
    on E: Exception do
    begin
      Result.Messaggio:='Errore durante la generazione del cartellino PDF: ' + E.Message;
      Exit;
    end;
  end;
end;

function TWM004FCartellinoMW.NumCartellini: Integer;
begin
  if Assigned(FDMemTableCartellini) then
    Result:=FDMemTableCartellini.RecordCount
  else
    Result:=0;
end;

function TWM004FCartellinoMW.StringaNumCartellini: String;
var num: Integer;
begin
  num:= NumCartellini;

  if num = 0 then
     Result:='Nessun cartellino'
  else if num = 1 then
    Result:='1 cartellino'
  else
    Result:=Format('%d cartellini',[num]);
end;

function TWM004FCartellinoMW.GetListaCartellini: TStringList;
begin
  Result:= TStringList.Create;

  if not FDMemTableCartellini.Active then
    Exit;

  FDMemTableCartellini.First;
  while not FDMemTableCartellini.Eof do
  begin
    //LData:=FDMemTableCartellini.FieldByName('DATA').AsDateTime;
    Result.Add(FDMemTableCartellini.FieldByName('LBL_DATA').AsString);
    //LLblValidato:=FDMemTableCartellini.FieldByName('LBL_VALIDATO').AsString;

    FDMemTableCartellini.Next;
  end;

  FDMemTableCartellini.First;
end;

function TWM004FCartellinoMW.ControllaDate(PMeseDa, PMeseA: TDateTime): TResCtrl;
begin
  Result.Clear;

  // modifica i mesi in modo che le corrispondenti date siano impostate al primo giorno del mese
  FMeseDa:=Trunc(StartOfTheMonth(PMeseDa));
  FMeseA:=Trunc(StartOfTheMonth(PMeseA));

  // range mesi di stampa
  if (FMeseDa < FMeseMin) or
     (FMeseA > FMeseMax) then
  begin
    Result.Messaggio:=Format('Periodo di ricerca esterno al range disponibile (%s - %s)',
                             [FMeseMin.ToString,FMeseMax.ToString]);
    Exit;
  end;

  if FMeseA < FMeseDa then
  begin
    Result.Messaggio:=Format('Periodo di ricerca non valido (%s - %s)',
                             [FormatDateTime('mmmm yyyy',FMeseDa),FormatDateTime('mmmm yyyy',FMeseA)]);
    Exit;
  end;

  Result.Ok:=True;
end;

function TWM004FCartellinoMW.AggiornaListaCartelliniSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;
var
  LRes: TRisultato;
  LDataSetList: TFDJSONDataSets;
begin
  if not Assigned(B110) or not Assigned(Infoclient) or not Assigned(ParametriLogin) then
  begin
    Result.Ok:=False;
    Result.Messaggio:='Impossibile aggiornare la lista dei cartellini, parametri incompleti';
    Exit;
  end;
  try
    FDMemTableCartellini.Close;
    // estrae dataset cartellini
    LRes:=B110.B110FServerMethodsDMClient.Cartellini(InfoClient.PrepareForServer,
                                                     ParametriLogin.PrepareForServer,
                                                     False,
                                                     FMeseDa,
                                                     FMeseA
                                                    );
    Result:=LRes.Check(TOutputCartellini);
    if Result.Ok then
    begin
      // prepara dataset cartellini
      try
        LDataSetList:=(LRes.Output as TOutputCartellini).JSONDatasets;
        FDMemTableCartellini.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
        FDMemTableCartellini.Open;
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

function TWM004FCartellinoMW.StampaCartellinoPdf(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PMese: String; PCodParStampa: String; PPathFilePdf: String) : TResCtrl;
var
  LMese: TDateTime;
  LPdfWrapper: TByteDynArrayWrapper;
  LByteArrPdf: TByteDynArray;
begin
  if not Assigned(B110) or not Assigned(Infoclient) or not Assigned(ParametriLogin) then
  begin
    Result.Ok:=False;
    Result.Messaggio:='Impossibile stampare il cartellino, parametri incompleti';
    Exit;
  end;

  if FDMemTableCartellini.Locate('LBL_DATA', PMese, []) = true then
  begin
    LMese:=FDMemTableCartellini.FieldByName('DATA').AsDateTime;
    LPdfWrapper:=nil;
    Result:=StampaCartellinoPdfSRV(B110, InfoClient, ParametriLogin, LMese, PCodParStampa, LPdfWrapper);

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
  end
  else
  begin
    Result.Ok:=False;
    Result.Messaggio:='Impossibile stampare il cartellino, mese selezionato non presente';
  end;
end;

end.
