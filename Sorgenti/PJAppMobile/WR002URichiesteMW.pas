unit WR002URichiesteMW;

interface

uses
  A000UCostanti,
  B110UClientModule,
  B110USharedTypes,
  Data.FireDACJSONReflect,
  FireDAC.Comp.Client,
  System.Generics.Collections,
  System.Sensors, WM000UUtils, C200UWebServicesTypes, C200UWebServicesUtils, System.SysUtils, System.Classes,
  System.StrUtils, FunzioniGenerali, System.Math, WM000UConstants, Data.DB, WM000UMemTableMW, MedpUnimPanelBase;

type

  TStatoRichieste = (DaAutorizzare, Autorizzate, Negate);

  TWR002FRichiesteMW = class(TWM000FMemTableMW)
    private
      function GetPeriodoA: TDatetime;
      function GetPeriodoDa: TDatetime;
      procedure SetPeriodoA(const Value: TDatetime);
      procedure SetPeriodoDa(const Value: TDatetime);

      function GetStatoRichieste: TStatoRichieste;
      procedure SetStatoRichieste(const Value: TStatoRichieste);
      //-----------------------------------
      function GetID: Integer;
      function GetNominativo: String;
      function GetTimbratura: String;
      function GetData: String;
      function GetOperazione: String;
      function GetOperazioneEstesa: String;
      function GetTimbraturaOrig: String;
      function GetDataRichiesta: String;
      function GetMotivazione: String;
      function GetLivelloAutorizzazione: Integer;
      //-----------------------------------
    protected
      FFiltriRichieste: TFiltriRichieste;

      FRichiesteTotali: Integer;
      FC018Revocabile: Boolean;
    public
      constructor Create;
      destructor Destroy; override;

      property RichiesteTotali: Integer read FRichiesteTotali write FRichiesteTotali;
      property C018Revocabile: Boolean read FC018Revocabile write FC018Revocabile;

      property FiltroPeriodoDa: TDatetime read GetPeriodoDa write SetPeriodoDa;
      property FiltroPeriodoA: TDatetime read GetPeriodoA write SetPeriodoA;
      property FiltroStatoRichiesta: TStatoRichieste read GetStatoRichieste write SetStatoRichieste;

      //--------------------------------------------------------------------
      property ID: Integer read GetID;
      property Nominativo: String read GetNominativo;
      property Timbratura: String read GetTimbratura;
      property TimbraturaOrig: String read GetTimbraturaOrig;
      property Data: String read GetData;
      property DataRichiesta: String read GetDataRichiesta;
      property Operazione: String read GetOperazione;
      property OperazioneEstesa: String read GetOperazioneEstesa;
      property Motivazione: String read GetMotivazione;
      property LivelloAutorizzazione: Integer read GetLivelloAutorizzazione;
      //--------------------------------------------------------------------

      function AggiornaRichiesteSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl; virtual; abstract;
  end;

implementation

{ TWM000RichiesteMW }

constructor TWR002FRichiesteMW.Create;
begin
  inherited;

  FFiltriRichieste:=TFiltriRichieste.Create('trDaAutorizzare',DATE_MIN,DATE_MAX,IncMonth(Date,-1),Date,0);
  FRichiesteTotali:=0;
end;

destructor TWR002FRichiesteMW.Destroy;
begin
  FreeAndNil(FFiltriRichieste);

  inherited;
end;

function TWR002FRichiesteMW.GetStatoRichieste: TStatoRichieste;
begin
  if FFiltriRichieste.FiltroVis ='trNegate' then
    Result:=TStatoRichieste.Negate
  else if FFiltriRichieste.FiltroVis ='trAutorizzate' then
    Result:=TStatoRichieste.Autorizzate
  else
    Result:=TStatoRichieste.DaAutorizzare;
end;

function TWR002FRichiesteMW.GetPeriodoA: TDatetime;
begin
  Result:=FFiltriRichieste.PeriodoAOriginale;
end;

function TWR002FRichiesteMW.GetPeriodoDa: TDatetime;
begin
  Result:=FFiltriRichieste.PeriodoDaOriginale;
end;

procedure TWR002FRichiesteMW.SetPeriodoA(const Value: TDatetime);
begin
  if FFiltriRichieste.FiltroVis <>'trDaAutorizzare' then
    FFiltriRichieste.PeriodoDa:=Value;

  FFiltriRichieste.PeriodoDaOriginale:=Value;
end;

procedure TWR002FRichiesteMW.SetPeriodoDa(const Value: TDatetime);
begin
  if FFiltriRichieste.FiltroVis <>'trDaAutorizzare' then
    FFiltriRichieste.PeriodoA:=Value;

  FFiltriRichieste.PeriodoAOriginale:=Value;
end;

procedure TWR002FRichiesteMW.SetStatoRichieste(const Value: TStatoRichieste);
begin
  case Value of
     DaAutorizzare: FFiltriRichieste.FiltroVis:='trDaAutorizzare';
     Autorizzate:   FFiltriRichieste.FiltroVis:='trAutorizzate';
     Negate:        FFiltriRichieste.FiltroVis:='trNegate'
  end;

  // periodo
  if FFiltriRichieste.FiltroVis = 'trDaAutorizzare' then
  begin
    FFiltriRichieste.PeriodoDa:=DATE_MIN;
    FFiltriRichieste.PeriodoA:=DATE_MAX;
    FFiltriRichieste.LimiteRecord:=0;
  end
  else
  begin
    FFiltriRichieste.PeriodoDa:=FFiltriRichieste.PeriodoDaOriginale;
    FFiltriRichieste.PeriodoA:=FFiltriRichieste.PeriodoAOriginale;
    FFiltriRichieste.LimiteRecord:=LIMITE_RICHIESTE_VISUALIZZATE;
  end;
end;
//-----------------------------------------------------------------------------------------------------------
function TWR002FRichiesteMW.GetData: String;
var LData: TDateTime;
begin
  if FDMemTable.Active then
  begin
    LData:=FDMemTable.FieldByName('DATA').AsDateTime;
    Result:=FormatDateTime('dd/mm/yyyy',LData);
  end
  else
    Result:='';
end;

function TWR002FRichiesteMW.GetDataRichiesta: String;
var LDataRichiesta: TDateTime;
begin
  if FDMemTable.Active then
  begin
    LDataRichiesta:=FDMemTable.FieldByName('DATA_RICHIESTA').AsDateTime;
    Result:=FormatDateTime('dd/mm/yyyy hh:mm',LDataRichiesta);
  end
  else
    Result:='';
end;

function TWR002FRichiesteMW.GetID: Integer;
begin
  if FDMemTable.Active then
    Result:=FDMemTable.FieldByName('ID').AsInteger
  else
    Result:=-1;
end;

function TWR002FRichiesteMW.GetMotivazione: String;
begin
  if (FDMemTable.FindField('MOTIVAZIONE') <> nil) and (FDMemTable.FindField('D_MOTIVAZIONE') <> nil) then
    Result:=FDMemTable.FieldByName('D_MOTIVAZIONE').AsString;
end;

function TWR002FRichiesteMW.GetNominativo: String;
begin
  if FDMemTable.Active then
    Result:=FDMemTable.FieldByName('NOMINATIVO').AsString
  else
    Result:='';
end;

function TWR002FRichiesteMW.GetLivelloAutorizzazione: Integer;
begin
  if FDMemTable.Active then
    Result:=FDMemTable.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger
  else
    Result:=-1;
end;

function TWR002FRichiesteMW.GetTimbratura: String;
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

function TWR002FRichiesteMW.GetTimbraturaOrig: String;
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

function TWR002FRichiesteMW.GetOperazione: String;
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

function TWR002FRichiesteMW.GetOperazioneEstesa: String;
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
//-----------------------------------------------------------------------------------------------------------
end.
