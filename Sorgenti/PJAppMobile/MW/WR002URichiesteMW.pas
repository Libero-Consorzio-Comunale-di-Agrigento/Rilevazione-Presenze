unit WR002URichiesteMW;

interface

uses
  A000UCostanti,
  B110UClientModule,
  B110USharedTypes,
  Data.FireDACJSONReflect,
  FireDAC.Comp.Client,
  System.Generics.Collections,
  System.Sensors, C200UWebServicesTypes, C200UWebServicesUtils, System.SysUtils, System.Classes,
  System.StrUtils, FunzioniGenerali, System.Math, WM000UConstants, Data.DB, WM000UDataSetMW, MedpUnimPanelBase,
  System.Variants, Oracle, OracleData, WR002UIterDM, C018UIterAutDM;

type

  TStatoRichieste = (srDaAutorizzare, srAutorizzate, srNegate);

  //incapsula il dataset delle richieste (proveniente da B100 o presente su DM)
  TWR002FRichiesteMW = class(TWM000FDataSetMW)
    private
      FRichiesteTotali: Integer;
      FC018Revocabile: Boolean;

      function GetPeriodoA: TDatetime;
      function GetPeriodoDa: TDatetime;
      procedure SetPeriodoA(const Value: TDatetime);
      procedure SetPeriodoDa(const Value: TDatetime);

      function GetStatoRichieste: TStatoRichieste;
      procedure SetStatoRichieste(const Value: TStatoRichieste);

      function GetID: Integer;
      function GetNominativo: String;
      function GetLivelloAutorizzazione: Integer;
      function GetDataRichiesta: TDateTime;
      function GetMotivazionePresente: Boolean;
      function GetMotivazione: String;
      function GetRevocabile: String;
      function GetAutorizzAutomatica: String;
      function GetCodIter: String;
      function GetMatricola: String;
      function GetProgressivo: Integer;
      function GetNominativoResp: String;
      function GetIdRevoca: Integer;
      function GetTipoRichiesta: String;
      function GetAutorizzUtile: String;
      function GetData: TDateTime;
      function GetSesso: String;
      function GetIdRevocato: Integer;
      function GetDataAutorizzazione: TDateTime;
      function GetAutorizzazione: String;
      function GetAutorizzAutomPrev: String;
      function GetAutorizzPrev: String;
      function GetAutorizzRevoca: String;
      function GetDTipoRichiesta: String;
      function GetResponsabilePrev: String;
      function GetMsgAutNo: String;
      function GetMsgAutSi: String;
    protected
      FProgressivo: Integer;
      FOperatore: String;
      FAutorizzatore: Boolean;   //True=Autorizzazione richieste, False=Inserimento richieste

      FIter: String;
      FTipoIter: TC018TipoIter;
      FFiltroAnag: String;
      FFiltriRichieste: TFiltriRichieste;
      WR002DM: TWR002FIterDM;
      C018: TC018FIterAutDM;

      procedure ApplicaFiltroDataset(Filtro: String);
    public
      constructor Create(TipoDataSet: TTipoDataSet);
      destructor Destroy; override;

      property Iter: String read FIter;

      property ID: Integer read GetID;
      property Progressivo: Integer read GetProgressivo;
      property Matricola: String read GetMatricola;
      property Sesso: String read GetSesso;
      property Nominativo: String read GetNominativo;
      property NominativoResp: String read GetNominativoResp;
      property CodIter: String read GetCodIter;
      property LivelloAutorizzazione: Integer read GetLivelloAutorizzazione;
      property DataAutorizzazione: TDateTime read GetDataAutorizzazione;
      property Autorizzazione: String read GetAutorizzazione;
      property AutorizzAutomatica: String read GetAutorizzAutomatica;
      property AutorizzAutomPrev: String read GetAutorizzAutomPrev;
      property AutorizzPrev: String read GetAutorizzPrev;
      property ResponsabilePrev: String read GetResponsabilePrev;
      property AutorizzRevoca: String read GetAutorizzRevoca;
      property DTipoRichiesta: String read GetDTipoRichiesta;
      property IdRevoca: Integer read GetIdRevoca;
      property IdRevocato: Integer read GetIdRevocato;
      property TipoRichiesta: String read GetTipoRichiesta;
      property AutorizzUtile: String read GetAutorizzUtile;
      property DataRichiesta: TDateTime read GetDataRichiesta;
      property Data: TDateTime read GetData;
      property Revocabile: String read GetRevocabile;
      property MsgAutSi: String read GetMsgAutSi;
      property MsgAutNo: String read GetMsgAutNo;

      property MotivazionePresente: Boolean read GetMotivazionePresente;
      property Motivazione: String read GetMotivazione;

      property RichiesteTotali: Integer read FRichiesteTotali write FRichiesteTotali;
      property C018Revocabile: Boolean read FC018Revocabile write FC018Revocabile;

      property FiltroPeriodoDa: TDatetime read GetPeriodoDa write SetPeriodoDa;
      property FiltroPeriodoA: TDatetime read GetPeriodoA write SetPeriodoA;
      property FiltroStatoRichiesta: TStatoRichieste read GetStatoRichieste write SetStatoRichieste;

      function AutorizzaTutti(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PAut: String): TResCtrl;

      procedure AnnullaInserimentoRichiesta;
      procedure AnnullaModificaRichiesta;

      function EliminaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl; virtual;
      function AggiornaRichiesteSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl; virtual;

      // metodi da implementare
      function AutorizzaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PAut: String): TResCtrl; virtual; abstract;
      function RevocaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl; virtual; abstract;
      function InserisciRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl; virtual; abstract;
      function ModificaRichiestaSRV: TResCtrl; virtual; abstract;
    const
      PREFIX_MODIF     = '(*) ';
  end;

implementation

{ TWM000RichiesteMW }

constructor TWR002FRichiesteMW.Create(TipoDataSet: TTipoDataSet);
begin
  inherited Create(TipoDataSet);

  FProgressivo:=0;
  FOperatore:='';
  FAutorizzatore:=False;

  FFiltriRichieste:=TFiltriRichieste.Create('trDaAutorizzare', DATE_MIN, DATE_MAX, IncMonth(Now,-1), IncMonth(Now, 1),0);
  FRichiesteTotali:=0;
  FFiltroAnag:='';
  FIter:='';
  WR002DM:=nil;
  C018:=nil;
end;

function TWR002FRichiesteMW.AggiornaRichiesteSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;
begin
  Result.Clear;

  if not Assigned(C018) then
  begin
    Result.Messaggio:='Errore nell''aggiornamento della lista delle richieste: C018 non inizializzato';
    Exit;
  end;

  if not Assigned(WR002DM) then
  begin
    Result.Messaggio:='Errore nell''aggiornamento della lista delle richieste: WR002DM non inizializzato';
    Exit;
  end;

  try
    if FFiltriRichieste.FiltroVis = 'trDaAutorizzare' then
      C018.TipoRichiesteSel:=[trDaAutorizzare]
    else if FFiltriRichieste.FiltroVis = 'trAutorizzate' then
      C018.TipoRichiesteSel:=[trAutorizzate]
    else if FFiltriRichieste.FiltroVis = 'trNegate' then
      C018.TipoRichiesteSel:=[trNegate];

    C018.Periodo.Inizio:=FFiltriRichieste.PeriodoDa;
    C018.Periodo.Fine:=FFiltriRichieste.PeriodoA;

    WR002DM.AggiornaRichieste(FFiltroAnag, C018);

    Result.Ok:=True;
  except
    on E: Exception do
      Result.Messaggio:='Errore nell''aggiornamento della lista delle richieste: ' + E.Message;
  end;
end;

function TWR002FRichiesteMW.EliminaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl;
begin
  Result.Clear;

  if not Assigned(C018) then
  begin
    Result.Messaggio:='Cancellazione della richiesta fallita! Motivo: C018 non inizializzato';
    Exit;
  end;

  try
    C018.CodIter:=CodIter;
    C018.Id:=Id;
    C018.EliminaIter;
    Commit;
    Result.Ok:=True;
  except
    on E:Exception do
    begin
      Commit;
      Result.Messaggio:='Cancellazione della richiesta fallita! Motivo: ' + E.Message;
    end;
  end;
end;

function TWR002FRichiesteMW.AutorizzaTutti(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PAut: String): TResCtrl;
begin
  First;
  while not Eof do
  begin
    Result:=AutorizzaRichiestaSRV(B110, InfoClient, ParametriLogin, PAut);
    if not Result.Ok then
      Exit;
    Next;
  end;
end;

procedure TWR002FRichiesteMW.AnnullaInserimentoRichiesta;
begin
  if Assigned(WR002DM) then
    WR002DM.AnnullaInserimentoRichiesta;
end;

procedure TWR002FRichiesteMW.AnnullaModificaRichiesta;
begin
  if Assigned(WR002DM) then
  begin
    WR002DM.AnnullaModificaRichiesta;
    Rollback;
  end;
end;

procedure TWR002FRichiesteMW.ApplicaFiltroDataSet(Filtro: String);
begin
  if FDataSet.Active then
  begin
    FDataSet.Filtered:=True;
    FDataSet.Filter:=Filtro;
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

destructor TWR002FRichiesteMW.Destroy;
begin
  FreeAndNil(FFiltriRichieste);
  inherited;
end;

{$region 'Getter/Setter'}
function TWR002FRichiesteMW.GetStatoRichieste: TStatoRichieste;
begin
  if FFiltriRichieste.FiltroVis ='trNegate' then
    Result:=TStatoRichieste.srNegate
  else if FFiltriRichieste.FiltroVis ='trAutorizzate' then
    Result:=TStatoRichieste.srAutorizzate
  else
    Result:=TStatoRichieste.srDaAutorizzare;
end;

procedure TWR002FRichiesteMW.SetStatoRichieste(const Value: TStatoRichieste);
begin
  case Value of
     srDaAutorizzare: FFiltriRichieste.FiltroVis:='trDaAutorizzare';
     srAutorizzate:   FFiltriRichieste.FiltroVis:='trAutorizzate';
     srNegate:        FFiltriRichieste.FiltroVis:='trNegate'
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

function TWR002FRichiesteMW.GetPeriodoA: TDatetime;
begin
  Result:=FFiltriRichieste.PeriodoAOriginale;
end;

function TWR002FRichiesteMW.GetPeriodoDa: TDatetime;
begin
  Result:=FFiltriRichieste.PeriodoDaOriginale;
end;

procedure TWR002FRichiesteMW.SetPeriodoA(const Value: TDatetime);
var DateValue: TDatetime;
begin
  if Value = DATE_NULL then
    DateValue:=DATE_MAX
  else
    DateValue:=Value;

  if FFiltriRichieste.FiltroVis <>'trDaAutorizzare' then
    FFiltriRichieste.PeriodoA:=DateValue;

  FFiltriRichieste.PeriodoAOriginale:=DateValue;
end;

procedure TWR002FRichiesteMW.SetPeriodoDa(const Value: TDatetime);
var DateValue: TDatetime;
begin
  if Value = DATE_NULL then
    DateValue:=DATE_MIN
  else
    DateValue:=Value;

  if FFiltriRichieste.FiltroVis <>'trDaAutorizzare' then
    FFiltriRichieste.PeriodoDa:=DateValue;

  FFiltriRichieste.PeriodoDaOriginale:=DateValue;
end;

function TWR002FRichiesteMW.GetID: Integer;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('ID') <> nil then
      Result:=FDataSet.FieldByName('ID').AsInteger
    else
      raise Exception.Create('Campo ID non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetIdRevoca: Integer;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('ID_REVOCA') <> nil then
      Result:=FDataSet.FieldByName('ID_REVOCA').AsInteger
    else
      raise Exception.Create('Campo ID_REVOCA non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetIdRevocato: Integer;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('ID_REVOCATO') <> nil then
      Result:=FDataSet.FieldByName('ID_REVOCATO').AsInteger
    else
      raise Exception.Create('Campo ID_REVOCATO non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetProgressivo: Integer;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('PROGRESSIVO') <> nil then
      Result:=FDataSet.FieldByName('PROGRESSIVO').AsInteger
    else
      raise Exception.Create('Campo PROGRESSIVO non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetNominativo: String;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('NOMINATIVO') <> nil then
      Result:=FDataSet.FieldByName('NOMINATIVO').AsString
    else
      raise Exception.Create('Campo NOMINATIVO non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetMatricola: String;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('MATRICOLA') <> nil then
      Result:=FDataSet.FieldByName('MATRICOLA').AsString
    else
      raise Exception.Create('Campo MATRICOLA non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetSesso: String;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('SESSO') <> nil then
      Result:=FDataSet.FieldByName('SESSO').AsString
    else
      raise Exception.Create('Campo SESSO non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetCodIter: String;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('COD_ITER') <> nil then
      Result:=FDataSet.FieldByName('COD_ITER').AsString
    else
      raise Exception.Create('Campo COD_ITER non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetTipoRichiesta: String;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('TIPO_RICHIESTA') <> nil then
      Result:=FDataSet.FieldByName('TIPO_RICHIESTA').AsString
    else
      raise Exception.Create('Campo TIPO_RICHIESTA non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetAutorizzAutomatica: String;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('AUTORIZZ_AUTOMATICA') <> nil then
      Result:=FDataSet.FieldByName('AUTORIZZ_AUTOMATICA').AsString
    else
      raise Exception.Create('Campo AUTORIZZ_AUTOMATICA non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetAutorizzAutomPrev: String;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('AUTORIZZ_AUTOM_PREV') <> nil then
      Result:=FDataSet.FieldByName('AUTORIZZ_AUTOM_PREV').AsString
    else
      raise Exception.Create('Campo AUTORIZZ_AUTOM_PREV non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetResponsabilePrev: String;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('RESPONSABILE_PREV') <> nil then
      Result:=FDataSet.FieldByName('RESPONSABILE_PREV').AsString
    else
      raise Exception.Create('Campo RESPONSABILE_PREV non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetAutorizzPrev: String;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('AUTORIZZ_PREV') <> nil then
      Result:=FDataSet.FieldByName('AUTORIZZ_PREV').AsString
    else
      raise Exception.Create('Campo AUTORIZZ_PREV non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetAutorizzRevoca: String;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('AUTORIZZ_REVOCA') <> nil then
      Result:=FDataSet.FieldByName('AUTORIZZ_REVOCA').AsString
    else
      raise Exception.Create('Campo AUTORIZZ_REVOCA non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetDTipoRichiesta: String;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('D_TIPO_REVOCA') <> nil then
      Result:=FDataSet.FieldByName('D_TIPO_REVOCA').AsString
    else
      raise Exception.Create('Campo D_TIPO_REVOCA non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetRevocabile: String;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('REVOCABILE') <> nil then
      Result:=FDataSet.FieldByName('REVOCABILE').AsString
    else
      raise Exception.Create('Campo REVOCABILE non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetDataRichiesta: TDateTime;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('DATA_RICHIESTA') <> nil then
    begin
      if FDataSet.FieldByName('DATA_RICHIESTA').IsNull then
        Result:=DATE_NULL
      else
        Result:=FDataSet.FieldByName('DATA_RICHIESTA').AsDateTime
    end
    else
      raise Exception.Create('Campo DATA_RICHIESTA non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetLivelloAutorizzazione: Integer;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('LIVELLO_AUTORIZZAZIONE') <> nil then
      Result:=FDataSet.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger
    else
      raise Exception.Create('Campo LIVELLO_AUTORIZZAZIONE non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetDataAutorizzazione: TDateTime;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('DATA_AUTORIZZAZIONE') <> nil then
    begin
      if FDataSet.FieldByName('DATA_AUTORIZZAZIONE').IsNull then
        Result:=DATE_NULL
      else
        Result:=FDataSet.FieldByName('DATA_AUTORIZZAZIONE').AsDateTime
    end
    else
      raise Exception.Create('Campo DATA_AUTORIZZAZIONE non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetAutorizzazione: String;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('AUTORIZZAZIONE') <> nil then
      Result:=FDataSet.FieldByName('AUTORIZZAZIONE').AsString
    else
      raise Exception.Create('Campo AUTORIZZAZIONE non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetNominativoResp: String;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('NOMINATIVO_RESP') <> nil then
      Result:=FDataSet.FieldByName('NOMINATIVO_RESP').AsString
    else
      raise Exception.Create('Campo NOMINATIVO_RESP non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetAutorizzUtile: String;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('AUTORIZZ_UTILE') <> nil then
      Result:=FDataSet.FieldByName('AUTORIZZ_UTILE').AsString
    else
      raise Exception.Create('Campo AUTORIZZ_UTILE non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetData: TDateTime;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('DATA') <> nil then
    begin
      if FDataSet.FieldByName('DATA').IsNull then
        Result:=DATE_NULL
      else
        Result:=FDataSet.FieldByName('DATA').AsDateTime
    end
    else
      raise Exception.Create('Campo DATA non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetMotivazionePresente: Boolean;
begin
  if FDataSet.Active then
    Result:=(FDataSet.FindField('MOTIVAZIONE') <> nil) and (FDataSet.FindField('D_MOTIVAZIONE') <> nil)
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetMsgAutNo: String;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('MSGAUT_NO') <> nil then
      Result:=FDataSet.FieldByName('MSGAUT_NO').AsString
    else
      raise Exception.Create('Campo MSGAUT_NO non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetMsgAutSi: String;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('MSGAUT_SI') <> nil then
      Result:=FDataSet.FieldByName('MSGAUT_SI').AsString
    else
      raise Exception.Create('Campo MSGAUT_SI non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWR002FRichiesteMW.GetMotivazione: String;
begin
  if FDataSet.Active then
  begin
    if (FDataSet.FindField('MOTIVAZIONE') <> nil) and (FDataSet.FindField('D_MOTIVAZIONE') <> nil) then
      Result:=FDataSet.FieldByName('D_MOTIVAZIONE').AsString
    else
      Result:='';
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;
{$endregion}

end.
