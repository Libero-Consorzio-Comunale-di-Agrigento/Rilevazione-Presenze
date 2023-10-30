unit WM013URicAssenzeMW;

interface

uses
  A000UCostanti,
  B110UClientModule,
  B110USharedTypes,
  Data.FireDACJSONReflect,
  FireDAC.Comp.Client,
  System.Generics.Collections,
  System.Generics.Defaults, WM000UDataSetMW,
  System.Sensors, C200UWebServicesTypes, C200UWebServicesUtils, System.SysUtils, System.Classes,
  System.StrUtils, FunzioniGenerali, System.Math, WM000UConstants, Data.DB, WR002URichiesteMW, System.Variants;

type

  TWM013FRicAssenzeMW = class(TWR002FRichiesteMW)
    private
      FDatiGiust: TDatiRichiestaGiust;

      fmtT257: TFDMemTable;
      fmtT265: TFDMemTable;
      fmtT275: TFDMemTable;
      fmtSG101: TFDMemTable;
      fmtT040: TFDMemTable;
      fmtT106: TFDMemTable;

      function GetCausale: String;
      function GetPeriodo: String;
      function GetCausaleEstesa: String;
      function GetFamiliare: String;
      function GetPeriodoEsteso: String;
      function GetPeriodoOrario: String;
      function GetTipoRichiestaEstesa: String;
      function GetTipoRichiestaModificata: String;
      function GetDataDal: TDateTime;
      function GetDataNascitaFamiliare: TDateTime;
      function GetCodCausale: String;
      function GetNoteMezzaGG: String;
      function GetTipoCausale: String;

      function GetPeriodoOrarioRichieste: String;
      function GetElaborato: String;
      function GetDataAl: TDateTime;
    const
      FRUIZ_I              = 'I';
      FRUIZ_M              = 'M';
      FRUIZ_N              = 'N';
      FRUIZ_D              = 'D';

      FRUIZ_I_TEXT         = 'Giornata';
      FRUIZ_M_TEXT         = 'Mezza giornata';
      FRUIZ_N_TEXT         = 'Numero ore';
      FRUIZ_D_TEXT         = 'Da ore / a ore';
    public
      constructor Create;
      destructor Destroy; override;

      property DatiGiustificativo: TDatiRichiestaGiust read FDatiGiust write FDatiGiust;

      property CodCausale: String read GetCodCausale;
      property Causale: String read GetCausale;
      property CausaleEstesa: String read GetCausaleEstesa;
      property Periodo: String read GetPeriodo;
      property PeriodoEsteso: String read GetPeriodoEsteso;
      property PeriodoOrario: String read GetPeriodoOrario;
      property PeriodoOrarioRichieste: String read GetPeriodoOrarioRichieste;
      property TipoRichiestaEstesa: String read GetTipoRichiestaEstesa;
      property TipoRichiestaModificata: String read GetTipoRichiestaModificata;
      property TipoCausale: String read GetTipoCausale;
      property Familiare: String read GetFamiliare;
      property DataNascitaFamiliare: TDateTime read GetDataNascitaFamiliare;
      property DataDal: TDateTime read GetDataDal;
      property DataAl: TDateTime read GetDataAl;
      property NoteMezzaGG: String read GetNoteMezzaGG;
      property Elaborato: String read GetElaborato;

      function IsCausalePresenza(PCodCausale: String): Boolean;
      function IsCausaleAssenza(PCodCausale: String): Boolean;

      function GetAccorpCausali(C90_W010CausPres: String): TList<TPair<String, String>>;
      function GetCausali(PC23_InsNegCatena, PC90_W010CausPres, PCodAccorpCausale, PDescAccorpCausale: String): TList<TPair<String, String>>;
      function GetFamiliari(PCausale: String; var RGestioneFam: Boolean): TList<TPair<String, String>>;
      function GetNote: TList<TPair<String, String>>;
      function GetMotivazioni(PCausale: String; var PCodMotivazioneDefault: String): TList<TPair<String, String>>;
      function GetTipiFruizione(const PCausale: String): TList<TPair<String, String>>;

      function AggiornaDatiNuovaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;

      function AggiornaRichiesteSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl; override;
      function RevocaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl; override;
      function EliminaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl; override;
      function InserisciRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl; override;

      function AutorizzaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PAut: String): TResCtrl; override;
  end;

implementation

constructor TWM013FRicAssenzeMW.Create;
begin
  inherited Create(tdFDMemTable);
  FIter:=ITER_GIUSTIF;

  fmtT257:=TFDMemTable.Create(nil);
  fmtT265:=TFDMemTable.Create(nil);
  fmtT275:=TFDMemTable.Create(nil);
  fmtSG101:=TFDMemTable.Create(nil);
  fmtT040:=TFDMemTable.Create(nil);
  fmtT106:=TFDMemTable.Create(nil);

  FDatiGiust:=TDatiRichiestaGiust.Create;
end;

destructor TWM013FRicAssenzeMW.Destroy;
begin
  if fmtT257.Active then fmtT257.Close;
  if fmtT265.Active then fmtT257.Close;
  if fmtT275.Active then fmtT257.Close;
  if fmtSG101.Active then fmtT257.Close;
  if fmtT040.Active then fmtT257.Close;
  if fmtT106.Active then fmtT257.Close;

  FreeAndNil(fmtT257);
  FreeAndNil(fmtT265);
  FreeAndNil(fmtT275);
  FreeAndNil(fmtSG101);
  FreeAndNil(fmtT040);
  FreeAndNil(fmtT106);

  FreeAndNil(FDatiGiust);
  inherited;
end;

function TWM013FRicAssenzeMW.AggiornaDatiNuovaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;
var
  LResT257: TResCtrl;
  LResT265: TResCtrl;
  LResT275: TResCtrl;
  LResSG101: TResCtrl;
  LResT106: TResCtrl;
  LResT040: TResCtrl;
begin
  try
    Result.Clear;

    LResT257:=B110.GetTabellaDizionarioSRV(InfoClient, ParametriLogin, fmtT257,B110_DIZ_TAB_T257,'',False);
    LResT265:=B110.GetTabellaDizionarioSRV(InfoClient, ParametriLogin, fmtT265,B110_DIZ_TAB_T265,'',True);
    LResT275:=B110.GetTabellaDizionarioSRV(InfoClient, ParametriLogin, fmtT275,B110_DIZ_TAB_T275,'',True);
    LResSG101:=B110.GetTabellaDizionarioSRV(InfoClient, ParametriLogin, fmtSG101,B110_DIZ_TAB_SG101,'',False);
    LResT106:=B110.GetTabellaDizionarioSRV(InfoClient, ParametriLogin, fmtT106,B110_DIZ_TAB_T106,'T050',False);
    LResT040:=B110.GetTabellaDizionarioSRV(InfoClient, ParametriLogin, fmtT040,B110_DIZ_TAB_T040_NOTE,'',False);

    if LResT257.Ok and LResT265.Ok and LResT275.Ok and LResSG101.Ok and LResT106.Ok and LResT040.Ok then
      Result.Ok:=True
    else
    begin
      Result.Ok:=False;
      Result.Messaggio:=Trim(LResT257.Messaggio + ' ' + LResT265.Messaggio + ' ' + LResT275.Messaggio + ' ' + LResSG101.Messaggio + ' ' + LResT106.Messaggio + ' ' + LResT040.Messaggio);
    end;
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

function TWM013FRicAssenzeMW.AggiornaRichiesteSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;
var
  LRes: TRisultato;
  LDataSetList: TFDJSONDataSets;
begin
  try
    FDMemTable.Close;
    // estrae l'elenco delle timbrature da autorizzare
    LRes:=B110.B110FServerMethodsDMClient.RichiesteGiustDip(InfoClient.PrepareForServer,
                                                           ParametriLogin.PrepareForServer,
                                                           FFiltriRichieste.Clone,
                                                           '');
    Result:=LRes.Check(TOutputRichiesteGiustDip);
    if Result.Ok then
    begin
      try
        LDataSetList:=(LRes.Output as TOutputRichiesteGiustDip).JSONDatasets;

        // elenco richieste
        FDMemTable.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
        FDMemTable.IndexFieldNames:='NOMINATIVO;MATRICOLA;DAL:D;TIPOGIUST;NUMEROORE;CAUSALE;DATA_RICHIESTA:D';

        // altri parametri
        RichiesteTotali:=((LRes.Output as TOutputRichiesteGiustDip).RichiesteTotali);
        C018Revocabile:=((LRes.Output as TOutputRichiesteGiustDip).C018Revocabile);

        FDMemTable.First;
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

function TWM013FRicAssenzeMW.RevocaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl;
var LRes: TRisultato;
begin
  try
    LRes:=B110.B110FServerMethodsDMClient
            .RevocaRichiestaGiust(InfoClient.PrepareForServer,
                                  ParametriLogin.PrepareForServer,
                                  FDatiGiust.Clone,
                                  ID,
                                  'R',
                                  DataDal,
                                  DataAl,
                                  '');

    //if Assigned(LRes.Output) then
    //  PRisposteMsg:=TOutputRevocaRichiestaGiust(LRes.Output).RisposteMsg.Clone;
    Result:=LRes.Check(TOutputRevocaRichiestaGiust);
    if Result.Ok then
      PRisposteMsg:=TOutputRevocaRichiestaGiust(LRes.Output).RisposteMsg.Clone
    else
      PRisposteMsg:=nil;

  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

function TWM013FRicAssenzeMW.InserisciRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl;
var LRes: TRisultato;
begin
  try
    LRes:=B110.B110FServerMethodsDMClient.InsRichiestaGiust(InfoClient.PrepareForServer,
                                                            ParametriLogin.PrepareForServer,
                                                            FDatiGiust.Clone,
                                                            '');

    //if Assigned(LRes.Output) then
    //  PRisposteMsg:=TOutputInsRichiestaGiust(LRes.Output).RisposteMsg.Clone;
    Result:=LRes.Check(TOutputInsRichiestaGiust);
    if Result.Ok then
      PRisposteMsg:=TOutputInsRichiestaGiust(LRes.Output).RisposteMsg.Clone
    else
      PRisposteMsg:=nil;
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

function TWM013FRicAssenzeMW.EliminaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl;
var LRes: TRisultato;
begin
  try
    LRes:=B110.B110FServerMethodsDMClient.CancRichiestaGiust(InfoClient.PrepareForServer,
                                                             ParametriLogin.PrepareForServer,
                                                             FDatiGiust.Clone,
                                                             ID,
                                                             '');
    //if Assigned(LRes.Output) then
    //  PRisposteMsg:=TOutputCancRichiestaGiust(LRes.Output).RisposteMsg.Clone;
    Result:=LRes.Check(TOutputCancRichiestaGiust);
    if Result.Ok then
      PRisposteMsg:=TOutputCancRichiestaGiust(LRes.Output).RisposteMsg.Clone
    else
      PRisposteMsg:=nil;
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

function TWM013FRicAssenzeMW.AutorizzaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PAut: String): TResCtrl;
begin
  raise Exception.Create('Funzione AutorizzaRichiesta non implementata');
end;

function TWM013FRicAssenzeMW.GetAccorpCausali(C90_W010CausPres: String): TList<TPair<String, String>>;
var LItem: TPair<String, String>;
    LListaCodici: TStringList;
    LCodice, LDescrizione: String;
begin
  try
    LListaCodici:=TStringList.Create;
    Result:=TList<TPair<String, String>>.Create;

    fmtT257.First;

    while not fmtT257.Eof do
    begin
      LCodice:=fmtT257.FieldByName('COD_CODICIACCORPCAUSALI').AsString;
      LDescrizione:=fmtT257.FieldByName('DESCRIZIONE').AsString;

      if LListaCodici.IndexOf(LCodice) < 0 then
      begin
        LListaCodici.Add(LCodice);

        LItem:=TPair<String, String>.Create(LCodice, LDescrizione);
        Result.Add(LItem);
      end;

      fmtT257.Next;
    end;

    if (C90_W010CausPres = 'S') and(fmtT275.RecordCount > 0) then
    begin
      LItem:=TPair<String, String>.Create('', 'Causali di presenza');
      Result.Add(LItem);
    end;

  finally
    FreeAndNil(LListaCodici);
  end;
end;

function TWM013FRicAssenzeMW.GetCausali(PC23_InsNegCatena, PC90_W010CausPres, PCodAccorpCausale, PDescAccorpCausale: String): TList<TPair<String, String>>;
var
  LCodice: String;
  LDescrizione: String;
  LItem: TPair<String, String>;
  LFruizAbil: Boolean;
  LInAccorpamento: Boolean;
  LCatenaOk: Boolean;
  Comparison: TComparison<TPair<String, String>>;
begin
  Result:=TList<TPair<String, String>>.Create;

  // causali di assenza
  fmtT265.First;
  while not fmtT265.Eof do
  begin
    LCodice:=fmtT265.FieldByName('CODICE').AsString;
    LDescrizione:=fmtT265.FieldByName('DESCRIZIONE').AsString;
    LFruizAbil:=(fmtT265.FieldByName('UM_INSERIMENTO').AsString = 'S') or
                (fmtT265.FieldByName('UM_INSERIMENTO_MG').AsString = 'S') or
                (fmtT265.FieldByName('UM_INSERIMENTO_H').AsString = 'S') or
                (fmtT265.FieldByName('UM_INSERIMENTO_D').AsString = 'S');
    LInAccorpamento:=((PCodAccorpCausale = '') and (PDescAccorpCausale <> 'Causali di presenza')) or
                     (fmtT257.Locate('COD_CODICIACCORPCAUSALI;COD_CAUSALE',VarArrayOf([PCodAccorpCausale,LCodice]),[]));

    LCatenaOk:=True;
    if (PC23_InsNegCatena = 'S') and
       (fmtT265.FieldByName('INIZIO_CATENA').AsString <> 'S') then
    begin
      LCatenaOk:=False;
    end;

    // aggiunge la causale alla lista se:
    // - ha fruizioni abilitate e
    // - fa parte del raggruppamento eventualmente selezionato
    // - è capo-catena nel caso il relativo parametro sia attivo
    if LFruizAbil and LInAccorpamento and LCatenaOk then
    begin
      LItem:=TPair<String, String>.Create(LCodice, LDescrizione);
      Result.Add(LItem);
    end;

    fmtT265.Next;
  end;

  // causali di presenza
  if PC90_W010CausPres = 'S' then
  begin
    fmtT275.First;
    while not fmtT275.Eof do
    begin
      LCodice:=fmtT275.FieldByName('CODICE').AsString;
      LDescrizione:=fmtT275.FieldByName('DESCRIZIONE').AsString;
      LFruizAbil:=(fmtT275.FieldByName('UM_INSERIMENTO_H').AsString = 'S') or
                  (fmtT275.FieldByName('UM_INSERIMENTO_D').AsString = 'S');

      LInAccorpamento:=((PCodAccorpCausale = '') or    //LAccorpCausaleText.Trim
                        (PDescAccorpCausale = 'Causali di presenza'));  //LAccorpCausaleText.Trim

      if LFruizAbil and LInAccorpamento then
      begin
        LItem:=TPair<String, String>.Create(LCodice, LDescrizione);
        Result.Add(LItem);
      end;

      fmtT275.Next;
    end;
  end;

  Comparison:=function(const Item1, Item2: TPair<String, String>): Integer
              begin
                Result:=TComparer<String>.Default.Compare(Item1.Key.ToUpper,Item2.Key.ToUpper);
              end;

  Result.Sort(TComparer<TPair<String, String>>.Construct(Comparison));
end;

function TWM013FRicAssenzeMW.GetFamiliari(PCausale: String; var RGestioneFam: Boolean): TList<TPair<String, String>>;
var LItem: TPair<String, String>;
    LDatanas: TDateTime;
    LCausAbil: Boolean;
    LCausaliAbilitate: String;
    LCognome: String;
    LNome: String;
begin
  Result:=TList<TPair<String, String>>.Create;

  RGestioneFam:=False;

  if not fmtT265.Locate('CODICE',PCausale,[]) then
    Exit;

  if fmtT265.FieldByName('FAMILIARI').AsString <> 'S' then
    Exit;

  RGestioneFam:=True;

  // elenco familiari
  fmtSG101.First;
  while not fmtSG101.Eof do
  begin
    LDatanas:=fmtSG101.FieldByName('DATANAS').AsDateTime;
    LCognome:=fmtSG101.FieldByName('COGNOME').AsString;
    LNome:=fmtSG101.FieldByName('NOME').AsString;
    LCausaliAbilitate:=fmtSG101.FieldByName('CAUSALI_ABILITATE').AsString;;
    LCausAbil:=(LCausaliAbilitate = '*') or
               (Format(',%s,',[LCausaliAbilitate]).Contains(Format(',%s,',[PCausale])));
    // aggiunge il familiare se è abilitato alla fruizione della causale attualmente selezionata
    if LCausAbil then
    begin
      LItem:=TPair<String, String>.Create(LDatanas.ToString, Format('%s %s',[LCognome,LNome]));
      Result.Add(LItem);
    end;

    fmtSG101.Next;
  end;
end;

function TWM013FRicAssenzeMW.IsCausalePresenza(PCodCausale: String): Boolean;
begin
  Result:=fmtT275.Locate('CODICE',PCodCausale,[]);
end;

function TWM013FRicAssenzeMW.IsCausaleAssenza(PCodCausale: String): Boolean;
begin
  Result:=fmtT265.Locate('CODICE',PCodCausale,[]);
end;

function TWM013FRicAssenzeMW.GetMotivazioni(PCausale: String; var PCodMotivazioneDefault: String): TList<TPair<String, String>>;
var LItem: TPair<String, String>;
    LCodice: String;
    LDescrizione: String;
    LCausali: String;
    LCodiceDefault: String;
begin
  Result:=TList<TPair<String, String>>.Create;

  LCodiceDefault:='';
  PCodMotivazioneDefault:='';
  fmtT106.First;
  while not fmtT106.Eof do
  begin
    LCodice:=fmtT106.FieldByName('CODICE').AsString;
    LDescrizione:=fmtT106.FieldByName('DESCRIZIONE').AsString;
    LCausali:=fmtT106.FieldByName('CAUSALI').AsString;
    LCodiceDefault:=fmtT106.FieldByName('CODICE_DEFAULT').AsString;

    // se l'elenco di causali è vuoto, si aggiungono tutte le motivazioni
    if (LCausali = '') or
       (Format(',%s,',[LCausali]).Contains(Format(',%s,',[PCausale]))) then
    begin
      LItem:=TPair<String, String>.Create(LCodice, LDescrizione);
      Result.Add(LItem);

      if LCodiceDefault = 'S' then
        PCodMotivazioneDefault:=LCodice;
    end;

    fmtT106.Next;
  end;
end;

function TWM013FRicAssenzeMW.GetNote: TList<TPair<String, String>>;
var LItem: TPair<String, String>;
begin
  Result:=TList<TPair<String, String>>.Create;

  fmtT040.First;
  while not fmtT040.Eof do
  begin
    LItem:=TPair<String, String>.Create(fmtT040.FieldByName('NOTE').AsString, '');
    Result.Add(LItem);

    fmtT040.Next;
  end;
end;

function TWM013FRicAssenzeMW.GetTipiFruizione(const PCausale: String): TList<TPair<String, String>>;
var LFruizG: Boolean;
    LFruizMG: Boolean;
    LFruizN: Boolean;
    LFruizD: Boolean;
begin
  Result:=TList<TPair<String, String>>.Create;

  if fmtT265.Locate('CODICE',PCausale,[]) then
  begin
    // causale di assenza
    LFruizG:=fmtT265.FieldByName('UM_INSERIMENTO').AsString = 'S';
    LFruizMG:=fmtT265.FieldByName('UM_INSERIMENTO_MG').AsString = 'S';
    LFruizN:=fmtT265.FieldByName('UM_INSERIMENTO_H').AsString = 'S';
    LFruizD:=fmtT265.FieldByName('UM_INSERIMENTO_D').AsString = 'S';
  end
  else if fmtT275.Locate('CODICE',PCausale,[]) then
  begin
    // causale di presenza
    LFruizG:=False;
    LFruizMG:=False;
    LFruizN:=fmtT275.FieldByName('UM_INSERIMENTO_H').AsString = 'S';
    LFruizD:=fmtT275.FieldByName('UM_INSERIMENTO_D').AsString = 'S';
  end
  else
  begin
    raise Exception.CreateFmt('La causale selezionata non è valida: %s',[PCausale]);
  end;

  // elenco tipi fruizione disponibili per la causale selezionata
  if LFruizG then
    Result.Add(TPair<String, String>.Create(FRUIZ_I, FRUIZ_I_TEXT));

  if LFruizMG then
    Result.Add(TPair<String, String>.Create(FRUIZ_M, FRUIZ_M_TEXT));

  if LFruizN then
    Result.Add(TPair<String, String>.Create(FRUIZ_N, FRUIZ_N_TEXT));

  if LFruizD then
    Result.Add(TPair<String, String>.Create(FRUIZ_D, FRUIZ_D_TEXT));
end;

function TWM013FRicAssenzeMW.GetCausale: String;
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

function TWM013FRicAssenzeMW.GetPeriodo: String;
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

function TWM013FRicAssenzeMW.GetCausaleEstesa: String;
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

function TWM013FRicAssenzeMW.GetCodCausale: String;
begin
  if FDMemTable.Active then
  begin
    Result:=FDMemTable.FieldByName('CAUSALE').AsString;
  end
  else
    Result:='';
end;

function TWM013FRicAssenzeMW.GetTipoCausale: String;
begin
  if FDMemTable.Active then
  begin
    Result:=FDMemTable.FieldByName('D_TIPO_CAUSALE').AsString;
  end
  else
    Result:='';
end;

function TWM013FRicAssenzeMW.GetNoteMezzaGG: String;
begin
  if FDMemTable.Active then
  begin
    Result:=FDMemTable.FieldByName('NOTE_GIUSTIFICATIVO').AsString;
  end
  else
    Result:='';
end;

function TWM013FRicAssenzeMW.GetTipoRichiestaEstesa: String;
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

function TWM013FRicAssenzeMW.GetTipoRichiestaModificata: String;
var LTipoRichiesta: String;
begin
  if FDMemTable.Active then
  begin
    LTipoRichiesta:=FDMemTable.FieldByName('TIPO_RICHIESTA').AsString;

    if LTipoRichiesta.Contains('(1)') then
      Result:=LTipoRichiesta.Replace('(1)',' (revocata)')
    else if LTipoRichiesta.Contains('(2)') then
      Result:=LTipoRichiesta.Replace('(2)',' (prev. non autorizzata)')
    else if LTipoRichiesta.Contains('(3)') then
      Result:=LTipoRichiesta.Replace('(3)',' (cancellata parz.)');
  end
  else
    Result:='';
end;

function TWM013FRicAssenzeMW.GetPeriodoEsteso: String;
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

function TWM013FRicAssenzeMW.GetPeriodoOrario: String;
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

function TWM013FRicAssenzeMW.GetPeriodoOrarioRichieste: String;
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

function TWM013FRicAssenzeMW.GetFamiliare: String;
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

function TWM013FRicAssenzeMW.GetDataDal: TDateTime;
begin
  if FDMemTable.Active then
  begin
    Result:=FDMemTable.FieldByName('DAL').AsDateTime;
  end
  else
    Result:=DATE_NULL;
end;

function TWM013FRicAssenzeMW.GetDataAl: TDateTime;
begin
  if FDMemTable.Active then
  begin
    Result:=FDMemTable.FieldByName('AL').AsDateTime;
  end
  else
    Result:=DATE_NULL;
end;

function TWM013FRicAssenzeMW.GetDataNascitaFamiliare: TDateTime;
begin
  if FDMemTable.Active then
  begin
    Result:=FDMemTable.FieldByName('DATANAS').AsDateTime;
  end
  else
    Result:=DATE_NULL;
end;

function TWM013FRicAssenzeMW.GetElaborato: String;
begin
  if FDMemTable.Active then
  begin
    Result:=FDMemTable.FieldByName('ELABORATO').AsString;
  end
  else
    Result:='';
end;

end.
