unit WM003UAutAssenzeMW;

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

  TWM003FAutAssenzeMW = class(TWR002FRichiesteMW)
    private
      fmtI096: TFDMemTable;

      function GetDescLivelloAutorizzazione: String;

      function GetCausale: String;
      function GetPeriodo: String;
      function GetCausaleEstesa: String;
      function GetFamiliare: String;
      function GetPeriodoEsteso: String;
      function GetPeriodoOrario: String;
      function GetTipoRichiestaEstesa: String;
      function GetDataDal: TDateTime;
      function GetDataNascitaFamiliare: TDateTime;
      function GetCodCausale: String;
      function GetNoteMezzaGG: String;
      function GetTipoCausale: String;
      function GetPeriodoOrarioRichieste: String;
      function GetElaborato: String;
      function GetDataAl: TDateTime;
    public
      constructor Create;
      destructor Destroy; override;

      property DescLivelloAutorizzazione: String read GetDescLivelloAutorizzazione;

      property CodCausale: String read GetCodCausale;
      property Causale: String read GetCausale;
      property CausaleEstesa: String read GetCausaleEstesa;
      property Periodo: String read GetPeriodo;
      property PeriodoEsteso: String read GetPeriodoEsteso;
      property PeriodoOrario: String read GetPeriodoOrario;
      property PeriodoOrarioRichieste: String read GetPeriodoOrarioRichieste;
      property TipoRichiestaEstesa: String read GetTipoRichiestaEstesa;
      property TipoCausale: String read GetTipoCausale;
      property Familiare: String read GetFamiliare;
      property DataNascitaFamiliare: TDateTime read GetDataNascitaFamiliare;
      property DataDal: TDateTime read GetDataDal;
      property DataAl: TDateTime read GetDataAl;
      property NoteMezzaGG: String read GetNoteMezzaGG;
      property Elaborato: String read GetElaborato;

      function AggiornaRichiesteSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl; override;
      function AutorizzaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PAut: String): TResCtrl; override;
      //non implementate
      function RevocaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl; override;
      function EliminaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl; override;
      function InserisciRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl; override;

  end;

implementation

constructor TWM003FAutAssenzeMW.Create;
begin
  inherited Create(tdFDMemTable);
  FIter:=ITER_GIUSTIF;
  fmtI096:=TFDMemTable.Create(nil);
end;

destructor TWM003FAutAssenzeMW.Destroy;
begin
  FreeAndNil(fmtI096);
  inherited;
end;

function TWM003FAutAssenzeMW.AggiornaRichiesteSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;
var
  LRes: TRisultato;
  LDataSetList: TFDJSONDataSets;
begin
  try
    FDMemTable.Close;

    // estrae l'elenco delle timbrature da autorizzare
    LRes:=B110.B110FServerMethodsDMClient.RichiesteGiust(InfoClient.PrepareForServer,
                                                           ParametriLogin.PrepareForServer,
                                                           False,
                                                           FFiltriRichieste.Clone,
                                                           '');
    Result:=LRes.Check(TOutputRichiesteGiust);
    if Result.Ok then
    begin
        try
          LDataSetList:=(LRes.Output as TOutputRichiesteGiust).JSONDatasets;

          // elenco richieste
          FDMemTable.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
          FDMemTable.IndexFieldNames:='NOMINATIVO;MATRICOLA;DAL:D;TIPOGIUST;NUMEROORE;CAUSALE;DATA_RICHIESTA:D';

          // altri parametri
          RichiesteTotali:=((LRes.Output as TOutputRichiesteGiust).RichiesteTotali);

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

function TWM003FAutAssenzeMW.AutorizzaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PAut: String): TResCtrl;
var
  LRes: TRisultato;
begin
  try
    // autorizza la richiesta di giutificativo
    LRes:=B110.B110FServerMethodsDMClient.AutorizzaRichiestaGiust(InfoClient.PrepareForServer,
                                                                  ParametriLogin.PrepareForServer,
                                                                  ID,
                                                                  PAut,
                                                                  '');
    Result:=LRes.Check(nil);
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

function TWM003FAutAssenzeMW.InserisciRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl;
begin
  raise Exception.Create('Funzione InserisciRichiesta non implementata');
end;

function TWM003FAutAssenzeMW.RevocaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl;
begin
  raise Exception.Create('Funzione RevocaRichiesta non implementata');
end;

function TWM003FAutAssenzeMW.EliminaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl;
begin
  raise Exception.Create('Funzione EliminaRichiesta non implementata');
end;

function TWM003FAutAssenzeMW.GetDescLivelloAutorizzazione: String;
begin
  if FDMemTable.Active and fmtI096.Active then
  begin
    Result:=VarToStr(fmtI096.Lookup('COD_ITER;LIVELLO',VarArrayOf([CodIter,Abs(LivelloAutorizzazione)]),'DESC_LIVELLO'));
  end;
end;

function TWM003FAutAssenzeMW.GetCausale: String;
var
  LTipoRichiesta: String;
  LCausale: String;
begin
  if FDMemTable.Active then
  begin
    LTipoRichiesta:=FDMemTable.FieldByName('TIPO_RICHIESTA').AsString;
    LCausale:=FDMemTable.FieldByName('D_CAUSALE').AsString;

    Result:=IfThen(LTipoRichiesta <> 'D',Format('(%s) ',[LTipoRichiesta])) + Format('%s',[LCausale]);
  end
  else
    Result:='';
end;

function TWM003FAutAssenzeMW.GetPeriodo: String;
var
  LDal: TDateTime;
  LAl: TDateTime;
  LPeriodoDalAl: String;
  LDaOreAOre: String;
begin
  if FDMemTable.Active then
  begin

    LDal:=FDMemTable.FieldByName('DAL').AsDateTime;
    LAl:=FDMemTable.FieldByName('AL').AsDateTime;

    LPeriodoDalAl:=FormatDateTime('dd/mm/yyyy',LDal);
    if LAl <> LDal then
      LPeriodoDalAl:=Format('%s - %s',[LPeriodoDalAl,FormatDateTime('dd/mm/yyyy',LAl)]);

    LDaOreAOre:=FDMemTable.FieldByName('D_DAORE_AORE').AsString;

    Result:=Format('%s %s',[LPeriodoDalAl,LDaOreAOre]);
  end
  else
    Result:='';
end;

function TWM003FAutAssenzeMW.GetCausaleEstesa: String;
var LCausale: String;
    LDescCausale: String;
begin
  if FDMemTable.Active then
  begin
    LCausale:=FDMemTable.FieldByName('CAUSALE').AsString;
    LDescCausale:=FDMemTable.FieldByName('D_CAUSALE').AsString;

    Result:=LCausale + IfThen(LDescCausale <> LCausale,Format(#13#10'%s',[LDescCausale]));
  end
  else
    Result:='';
end;

function TWM003FAutAssenzeMW.GetCodCausale: String;
begin
  if FDMemTable.Active then
  begin
    Result:=FDMemTable.FieldByName('CAUSALE').AsString;
  end
  else
    Result:='';
end;

function TWM003FAutAssenzeMW.GetTipoCausale: String;
begin
  if FDMemTable.Active then
  begin
    Result:=FDMemTable.FieldByName('D_TIPO_CAUSALE').AsString;
  end
  else
    Result:='';
end;

function TWM003FAutAssenzeMW.GetNoteMezzaGG: String;
begin
  if FDMemTable.Active then
  begin
    Result:=FDMemTable.FieldByName('NOTE_GIUSTIFICATIVO').AsString;
  end
  else
    Result:='';
end;

function TWM003FAutAssenzeMW.GetTipoRichiestaEstesa: String;
var LTipoRichiesta: String;
begin
  if FDMemTable.Active then
  begin
    LTipoRichiesta:=FDMemTable.FieldByName('TIPO_RICHIESTA').AsString;

    if LTipoRichiesta = 'P' then
      Result:='Preventiva'
    else if LTipoRichiesta = 'D' then
      Result:='Definitiva'
    else if LTipoRichiesta = 'R' then
      Result:='Revoca'
    else
      Result:=LTipoRichiesta;
  end
  else
    Result:='';
end;

function TWM003FAutAssenzeMW.GetPeriodoEsteso: String;
var LDal: TDateTime;
    LAl: TDateTime;
begin
  if FDMemTable.Active then
  begin
    LDal:=FDMemTable.FieldByName('DAL').AsDateTime;
    LAl:=FDMemTable.FieldByName('AL').AsDateTime;

    if LDal = LAl then
      Result:=FormatDateTime('dd/mm/yyyy',LDal)
    else
      Result:=Format('%s - %s'#13#10'(durata: %d gg.)',[FormatDateTime('dd/mm/yyyy',LDal),FormatDateTime('dd/mm/yyyy',LAl),Trunc(LAl - LDal) + 1]);
  end
  else
    Result:='';
end;

function TWM003FAutAssenzeMW.GetPeriodoOrario: String;
var LTipoGiust: String;
    LDaOre: String;
    LAOre: String;
begin
  if FDMemTable.Active then
  begin
    LTipoGiust:=FDMemTable.FieldByName('TIPOGIUST').AsString;
    LDaOre:=FDMemTable.FieldByName('NUMEROORE').AsString;
    LAOre:=FDMemTable.FieldByName('AORE').AsString;

    Result:=PeriodoEsteso + #13#10;

    if LTipoGiust = 'I' then
      Result:=Result + 'giornata intera'
    else if LTipoGiust = 'M' then
      Result:=Result + 'mezza giornata' + IfThen(LDaOre <> '',Format(' (%s)',[LDaOre]))
    else if LTipoGiust = 'N' then
      Result:=Result + 'num. ore: ' + LDaOre
    else if LTipoGiust = 'D' then
      Result:=Result + Format('dalle %s alle %s',[LDaOre,LAOre]);
  end
  else
    Result:='';
end;

function TWM003FAutAssenzeMW.GetPeriodoOrarioRichieste: String;
var LTipoGiust: String;
    LDaOre: String;
    LAOre: String;
begin
  if FDMemTable.Active then
  begin
    LTipoGiust:=FDMemTable.FieldByName('TIPOGIUST').AsString;
    LDaOre:=FDMemTable.FieldByName('NUMEROORE').AsString;
    LAOre:=FDMemTable.FieldByName('AORE').AsString;

    Result:=PeriodoEsteso + #13#10;

    if LTipoGiust = 'I' then
      Result:=Result + 'giornata intera'
    else if LTipoGiust = 'M' then
      Result:=Result + 'mezza giornata' + IfThen(LDaOre <> '',Format(' (%s)',[LDaOre])) + IfThen(NoteMezzaGG <> '',Format(' [%s]',[NoteMezzaGG]))
    else if LTipoGiust = 'N' then
      Result:=Result + 'num. ore: ' + LDaOre
    else if LTipoGiust = 'D' then
      Result:=Result + Format('dalle %s alle %s',[LDaOre,LAOre]);
  end
  else
    Result:='';
end;

function TWM003FAutAssenzeMW.GetFamiliare: String;
var LDataNas: TDateTime;
begin
  if FDMemTable.Active then
  begin
    LDataNas:=FDMemTable.FieldByName('DATANAS').AsDateTime;

    if LDataNas <> DATE_NULL then
      Result:=FormatDateTime('dd/mm/yyyy hh:mm',LDataNas)
    else
      Result:='';
  end
  else
    Result:='';
end;

function TWM003FAutAssenzeMW.GetDataDal: TDateTime;
begin
  if FDMemTable.Active then
  begin
    Result:=FDMemTable.FieldByName('DAL').AsDateTime;
  end
  else
    Result:=DATE_NULL;
end;

function TWM003FAutAssenzeMW.GetDataAl: TDateTime;
begin
  if FDMemTable.Active then
  begin
    Result:=FDMemTable.FieldByName('AL').AsDateTime;
  end
  else
    Result:=DATE_NULL;
end;

function TWM003FAutAssenzeMW.GetDataNascitaFamiliare: TDateTime;
begin
  if FDMemTable.Active then
  begin
    Result:=FDMemTable.FieldByName('DATANAS').AsDateTime;
  end
  else
    Result:=DATE_NULL;
end;

function TWM003FAutAssenzeMW.GetElaborato: String;
begin
  if FDMemTable.Active then
  begin
    Result:=FDMemTable.FieldByName('ELABORATO').AsString;
  end
  else
    Result:='';
end;

end.
