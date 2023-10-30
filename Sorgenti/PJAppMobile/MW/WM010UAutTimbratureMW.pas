unit WM010UAutTimbratureMW;

interface

uses
  A000UCostanti,
  B110UClientModule,
  B110USharedTypes,
  Data.FireDACJSONReflect,
  FireDAC.Comp.Client,
  System.Generics.Collections, WM000UDataSetMW,
  System.Sensors, C200UWebServicesTypes, C200UWebServicesUtils, System.SysUtils, System.Classes,
  System.StrUtils, FunzioniGenerali, System.Math, WM000UConstants, Data.DB, WR002URichiesteMW, System.Variants;

type

  TWM010FAutTimbratureMW = class(TWR002FRichiesteMW)
    private
      fmtI096: TFDMemTable;

      function GetDescLivelloAutorizzazione: String;
      function GetTimbratura: String;
      function GetTimbraturaOrig: String;
      function GetOperazione: String;
      function GetOperazioneEstesa: String;

    public
      constructor Create;
      destructor Destroy; override;

      property DescLivelloAutorizzazione: String read GetDescLivelloAutorizzazione;
      property Timbratura: String read GetTimbratura;
      property TimbraturaOrig: String read GetTimbraturaOrig;
      property Operazione: String read GetOperazione;
      property OperazioneEstesa: String read GetOperazioneEstesa;

      function AggiornaRichiesteSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl; override;
      function AutorizzaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PAut: String): TResCtrl; override;
      //non implementate
      function RevocaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl; override;
      function EliminaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl; override;
      function InserisciRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl; override;
  end;

implementation

constructor TWM010FAutTimbratureMW.Create;
begin
  inherited Create(tdFDMemTable);;
  FIter:=ITER_TIMBR;
  fmtI096:=TFDMemTable.Create(nil);
end;

destructor TWM010FAutTimbratureMW.Destroy;
begin
  FreeAndNil(fmtI096);
  inherited;
end;

function TWM010FAutTimbratureMW.AggiornaRichiesteSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;
var
  LRes: TRisultato;
  LDataSetList: TFDJSONDataSets;
begin
  try
    FDMemTable.Close;  // svuota tabella

    // estrae l'elenco delle timbrature da autorizzare
    LRes:=B110.B110FServerMethodsDMClient.RichiesteTimb(InfoClient.PrepareForServer,
                                                           ParametriLogin.PrepareForServer,
                                                           False,
                                                           FFiltriRichieste.Clone,
                                                           '');
    Result:=LRes.Check(TOutputRichiesteTimb);
    if Result.Ok then
    begin
      try
        LDataSetList:=(LRes.Output as TOutputRichiesteTimb).JSONDatasets;

        // elenco richieste
        FDMemTable.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
        FDMemTable.IndexFieldNames:='NOMINATIVO;MATRICOLA;DATA:D;ORA;DATA_RICHIESTA:D';

        // altri parametri
        RichiesteTotali:=((LRes.Output as TOutputRichiesteTimb).RichiesteTotali);

        FDMemTable.First;
      finally
        FreeAndNil(LDataSetList);
      end;

      Result:=B110.GetTabellaDizionarioSRV(InfoClient, ParametriLogin, fmtI096, B110_DIZ_TAB_I096, FIter, False);

      if Result.Ok then
        if not fmtI096.Active then
          fmtI096.Open;
    end;
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

function TWM010FAutTimbratureMW.AutorizzaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PAut: String): TResCtrl;
var
  LRes: TRisultato;
begin
  try
    // autorizza la richiesta di timbratura
    LRes:=B110.B110FServerMethodsDMClient.AutorizzaRichiestaTimb(InfoClient.PrepareForServer,
                                                                 ParametriLogin.PrepareForServer,
                                                                 ID,
                                                                 PAut,
                                                                 '');
    Result:=LRes.Check(nil); // verifica risultato
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

function TWM010FAutTimbratureMW.GetDescLivelloAutorizzazione: String;
begin
  if FDMemTable.Active and fmtI096.Active then
    Result:=VarToStr(fmtI096.Lookup('COD_ITER;LIVELLO',VarArrayOf([CodIter,Abs(LivelloAutorizzazione)]),'DESC_LIVELLO'))
  else
    Result:='';
end;

// TIMBRATURA
//--------------------------------------------------------------------------------------------------------------
function TWM010FAutTimbratureMW.GetTimbratura: String;
var
    LOra: String;
    LOperazione: String;
    LVerso: String;
    LRilevatore: String;
    LCausale: String;
    LVersoFmt: string;
    LCausaleFmt: string;
    LRilevatoreFmt: string;
    LIsVersoModif: Boolean;
    LIsCausaleModif: Boolean;
    LIsRilevatoreModif: Boolean;
    LVersoOrig: String;
    LRilevatoreOrig: String;
    LCausaleOrig: String;
begin
  if FDMemTable.Active then
  begin
    LOperazione:=FDMemTable.FieldByName('OPERAZIONE').AsString;
    LVerso:=FDMemTable.FieldByName('VERSO').AsString;
    LVersoOrig:=FDMemTable.FieldByName('VERSO_ORIG').AsString;
    LIsVersoModif:=LVerso <> LVersoOrig;
    LOra:=FDMemTable.FieldByName('ORA').AsString;
    LCausale:=FDMemTable.FieldByName('CAUSALE').AsString;
    LCausaleOrig:=FDMemTable.FieldByName('CAUSALE_ORIG').AsString;
    LIsCausaleModif:=LCausale <> LCausaleOrig;
    LRilevatore:=FDMemTable.FieldByName('RILEVATORE_RICH').AsString;
    LRilevatoreOrig:=FDMemTable.FieldByName('RILEVATORE_ORIG').AsString;
    LIsRilevatoreModif:=LRilevatore <> LRilevatoreOrig;

    LVersoFmt:=IfThen((LOperazione = 'M') and (LIsVersoModif),PREFIX_MODIF) + LVerso;
    LRilevatoreFmt:=IfThen((LOperazione = 'M') and (LIsRilevatoreModif),PREFIX_MODIF) + LRilevatore;
    LCausaleFmt:=IfThen((LOperazione = 'M') and (LIsCausaleModif),PREFIX_MODIF) + LCausale;

    Result:=Format('%s %s %s %s',[LOra,LVersoFmt,LRilevatoreFmt,LCausaleFmt]);
  end
  else
    Result:='';
end;

function TWM010FAutTimbratureMW.GetTimbraturaOrig: String;
var LOra: String;
    LVersoOrig: String;
    LRilevatoreOrig: String;
    LCausaleOrig: String;
begin
  if FDMemTable.Active then
  begin
    LVersoOrig:=FDMemTable.FieldByName('VERSO_ORIG').AsString;
    LOra:=FDMemTable.FieldByName('ORA').AsString;
    LCausaleOrig:=FDMemTable.FieldByName('CAUSALE_ORIG').AsString;
    LRilevatoreOrig:=FDMemTable.FieldByName('RILEVATORE_ORIG').AsString;

    Result:=Format('%s %s %s %s',[LOra,LVersoOrig,LRilevatoreOrig,LCausaleOrig]);
  end
  else
    Result:='';
end;

function TWM010FAutTimbratureMW.InserisciRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl;
begin
  raise Exception.Create('Funzione InserisciRichiesta non implementata');
end;

function TWM010FAutTimbratureMW.RevocaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl;
begin
  raise Exception.Create('Funzione RevocaRichiesta non implementata');
end;

function TWM010FAutTimbratureMW.EliminaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl;
begin
  raise Exception.Create('Funzione EliminaRichiesta non implementata');
end;

function TWM010FAutTimbratureMW.GetOperazione: String;
var LOperazione: String;
begin
  if FDMemTable.Active then
  begin
    LOperazione:=FDMemTable.FieldByName('OPERAZIONE').AsString;

    if LOperazione = 'I' then
      Result:='INS'
    else if LOperazione = 'M' then
      Result:='MOD'
    else if LOperazione = 'C' then
      Result:='CANC'
    else
      Result:=LOperazione;
  end
  else
    Result:='';
end;

function TWM010FAutTimbratureMW.GetOperazioneEstesa: String;
var LOperazione: String;
    LRilevatore: String;
    LRilevatoreOrig: String;
    LCausale: String;
    LCausaleOrig: String;
    LVerso: String;
    LVersoOrig: String;
    LIsVersoModif: Boolean;
    LIsCausaleModif: Boolean;
    LIsRilevatoreModif: Boolean;
begin
  LOperazione:=FDMemTable.FieldByName('OPERAZIONE').AsString;
  LVerso:=FDMemTable.FieldByName('VERSO').AsString;
  LVersoOrig:=FDMemTable.FieldByName('VERSO_ORIG').AsString;
  LIsVersoModif:=LVerso <> LVersoOrig;
  LCausale:=FDMemTable.FieldByName('CAUSALE').AsString;
  LCausaleOrig:=FDMemTable.FieldByName('CAUSALE_ORIG').AsString;
  LIsCausaleModif:=LCausale <> LCausaleOrig;
  LRilevatore:=FDMemTable.FieldByName('RILEVATORE_RICH').AsString;
  LRilevatoreOrig:=FDMemTable.FieldByName('RILEVATORE_ORIG').AsString;
  LIsRilevatoreModif:=LRilevatore <> LRilevatoreOrig;

  if LOperazione = 'I' then
    Result:='Inserimento'
  else if LOperazione = 'M' then
  begin
    Result:='Modifica';

    if LIsVersoModif then
      Result:=Result + #13#10 + Format('- cambio verso: %s -> %s',[LVersoOrig,LVerso]);

    if LIsCausaleModif then
    begin
      if LCausaleOrig = '' then
        Result:=Result + #13#10 + Format('- impostazione causale %s',[LCausale])
      else if LCausale = '' then
        Result:=Result + #13#10 + Format('- rimozione causale %s',[LCausaleOrig])
      else
        Result:=Result + #13#10 + Format('- modifica causale: %s -> %s',[LCausaleOrig,LCausale]);
    end;

    if LIsRilevatoreModif then
    begin
      if LRilevatoreOrig = '' then
        Result:=Result + #13#10 + Format('- impostazione rilevatore %s',[LRilevatore])
      else if LRilevatore = '' then
        Result:=Result + #13#10 + Format('- rimozione rilevatore %s',[LRilevatoreOrig])
      else
        Result:=Result + #13#10 + Format('- modifica rilevatore: %s -> %s',[LRilevatoreOrig,LRilevatore]);
    end;
  end
  else if LOperazione = 'C' then
    Result:='Cancellazione';
end;

end.
