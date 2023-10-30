unit A020UCausPresenzeStoricoMW;

interface

uses
  System.SysUtils, System.Classes, Data.DB, OracleData, System.Generics.Collections, Oracle,
  A000UMessaggi, A000UCostanti, C180FunzioniGenerali, R005UDataModuleMW,
  StrUtils, Datasnap.DBClient, Variants;

type
  TA020ElementoListaStorico = class
    ColonnaDato,Descrizione:String;
    Decorrenza,FineDecorrenza:TDateTime;
    ValoreDato,DescValoreDato:String;
    IndiceDato:Integer;
  end;

  TA020DescrizioneElementoStorico = record
    Nome,Descrizione:String;
  end;

  TA020TipoDescrValoreCampo = (
    tdvcSiNo,
    tdvcConteggioTimbInterna,
    tdvcIntersezioneTimbrature
  );

  TA020FCausPresenzeStoricoMW = class(TR005FDataModuleMW)
    selT275: TOracleDataSet;
    selT235: TOracleDataSet;
    insT235Nuovo: TOracleQuery;
    insT235NuovoCompleto: TOracleQuery;
    cdsStoriaParamStorizz: TClientDataSet;
    cdsStoriaParamStorizzDATO: TStringField;
    cdsStoriaParamStorizzDECORRENZA: TStringField;
    cdsStoriaParamStorizzFINE_DECORRENZA: TStringField;
    cdsStoriaParamStorizzVALORE: TStringField;
    selT275CAUS: TOracleDataSet;
    selCdzAbilitazione: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FIdCausale:Integer;
    FDecorrenze:TArray<TDateTime>; // Array con tutte le decorrenze esistenti per questa causale
    FIndiceDecorrenzaCorrente:Integer; // Indice in FDecorrenze del periodo corrente
    FStoriaDati:TObjectList<TA020ElementoListaStorico>;
    FCodInterno: String;
    FTipoConteggio: String;
    FOreNormali: String;
    function CampoInListaStorico(NomeCampo:String):Boolean;
    function GetDescrizioneCampo(Campo:String):String;
    function GetDescrizioneValoreCampo(Item:String;TipoDescr:TA020TipoDescrValoreCampo):String;
    const
      D_DatiStoricizzatiT235: array[0..15] of TA020DescrizioneElementoStorico = (
        (Nome:'DESCRIZIONE';                 Descrizione:'Descrizione'),
        (Nome:'CAUSCOMP_DEBITOGG';           Descrizione:'Causale per compensazione debito gg.'),
        (Nome:'DETRAZ_RIEPPR_SEQ';           Descrizione:'Ordine di detrazione straordinario'),
        (Nome:'CONDIZIONE_ABILITAZIONE';     Descrizione:'Condizione SQL per abilitare/disabilitare il conteggio causale'),
        //(Nome:'GIUST_DAA_RECUP_FLEX';       Descrizione:'Il giustificativo dalle..alle è recuperabile in uscita')//MESSINA_UNIVERSITA - per il mometno non visibile
        {(Nome:'NONABILITATA_ELIMINATIMB';   Descrizione:'Timbrature non considerate se causale non abilitata'),
        (Nome:'NONACCOPPIATA_ANOMBLOCC';    Descrizione:'Anomalia bloccante se causale non accoppiata')}
        (Nome:'ITER_AUTSTR_ARROT_LIQ';       Descrizione:'Arrotondamento quantità richiedibile in liquidazione'),
        (Nome:'ITER_AUTSTR_ARROT_LIQ_FASCE'; Descrizione:'Arrotondamento liquidabile applicato sulle singole fasce'),
        (Nome:'MATURAMENSA';                 Descrizione:'Pausa mensa: Matura pausa mensa'),
        (Nome:'TIMB_PM';                     Descrizione:'Pausa mensa: considera i giustificativi dalle..alle'),
        (Nome:'TIMB_PM_H';                   Descrizione:'Pausa mensa: considera i giustificativi in numero ore'),
        (Nome:'TIMB_PM_DETRAZ';              Descrizione:'Pausa mensa: ore rese conteggiate al netto della pausa mensa'),
        (Nome:'INTERSEZIONE_TIMBRATURE';     Descrizione:'Sovrapposizione su timbrature'),
        (Nome:'CONTEGGIO_TIMB_INTERNA';      Descrizione:'Tipo di conteggio se esiste timbratura interna'),
        (Nome:'AUTOCOMPLETAMENTO_UE';        Descrizione:'Auto-completamento se manca una causale'),
        (Nome:'SEPARA_CAUSALI_UE';           Descrizione:'Mantiene le causalizzazioni separate'),
        (Nome:'SPEZZ_STRAORD';               Descrizione:'Applica le regole degli spezzoni di straordinario'),
        (Nome:'RICONOSCIMENTO_TURNO';        Descrizione:'Riconoscimento turno anche se causalizzato')
      );
      D_SiNo: array[0..1] of TItemsValues = (
        (Item:'S';     Value:'Sì'),
        (Item:'N';     Value:'No')
      );
      D_ConteggioTimbInterna: array[0..2] of TItemsValues = (
        (Item:'P';     Value:'Termina prima della timbratura'),
        (Item:'S';     Value:'Scelta intervallo maggiore'),
        (Item:'C';     Value:'Compensazione')
      );
      D_IntersezioneTimbrature: array[0..2] of TItemsValues = (
        (Item:'E';     Value:'Conteggia entrambi'),
        (Item:'T';     Value:'Conteggia timbrature'),
        (Item:'G';     Value:'Conteggia giustificativi')
      );
      DescrizioneIniziale:String = 'parametri originali';
  public
    procedure Inizializza(IdCausale:Integer);
    procedure ApriT275;
    procedure ApriT235;
    procedure ChiudiT235;
    procedure ElaboraArrayDecorrenze(DataPeriodo:TDateTime);
    procedure ElaboraStoriaDati(DataPeriodo:TDateTime);
    procedure CreaRecordVuoto(ID:Integer);
    procedure CreaCopiaParametriStorici(IDEsistente,IDNuovo:Integer);
    procedure SvuotaCDSStoriaDati;
    procedure ValorizzaCDSStoriaDati;
    procedure ValidazioneQueryCdzAbilitazione(SQL:String);
    property IdCausale:Integer read FIdCausale write FIdCausale;
    property OreNormali:String read FOreNormali;
    property TipoConteggio:String read FTipoConteggio;
    property CodInterno:String read FCodInterno;
    property Decorrenze:TArray<TDateTime> read FDecorrenze;
    property IndiceDecorrenzaCorrente:Integer read FIndiceDecorrenzaCorrente;
    property StoriaDati:TObjectList<TA020ElementoListaStorico> read FStoriaDati;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA020FCausPresenzeStoricoMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  SetLength(FDecorrenze,0);
  FIndiceDecorrenzaCorrente:=-1;
  cdsStoriaParamStorizz.CreateDataSet;
end;

procedure TA020FCausPresenzeStoricoMW.DataModuleDestroy(Sender: TObject);
begin
  if (FStoriaDati <> nil) then
    FreeAndNil(FStoriaDati);
  selT235.Close;
  inherited;
end;

procedure TA020FCausPresenzeStoricoMW.Inizializza(IdCausale:Integer);
begin
   // Reimposto il MW allo stato iniziale
  selT235.Close;
  selT235.ClearVariables;
  if FStoriaDati <> nil then
    FreeAndNil(FStoriaDati);
  SetLength(FDecorrenze,0);
  FIndiceDecorrenzaCorrente:=-1;
  cdsStoriaParamStorizz.EmptyDataSet;
  // Imposto le variabili interne
  FIDCausale:=IDCausale;
  selT235.SetVariable('ID',FIDCausale);

  //Leggo parametri non storici della causale
  selT275CAUS.Close;
  selT275CAUS.SetVariable('ID',FIDCausale);
  selT275CAUS.Open;
  FOreNormali:=selT275CAUS.FieldByName('ORENORMALI').AsString;
  FTipoConteggio:=selT275CAUS.FieldByName('TIPOCONTEGGIO').AsString;
  FCodInterno:=selT275CAUS.FieldByName('CODINTERNO').AsString;
  selT275CAUS.Close;
end;

procedure TA020FCausPresenzeStoricoMW.ApriT275;
begin
  // Per ora ci basterebbe avere il record della causale corrente, ma in futuro
  // potrebbe servirci per popolare una lista di causali.
  selT275.Close;
  selT275.Open;
end;

procedure TA020FCausPresenzeStoricoMW.ApriT235;
begin
  selT235.Close;
  selT235.Open;
end;

procedure TA020FCausPresenzeStoricoMW.ChiudiT235;
begin
  selT235.Close;
end;

procedure TA020FCausPresenzeStoricoMW.ElaboraArrayDecorrenze(DataPeriodo:TDateTime);
var
  I:Integer;
begin
  I:=0;
  selT235.First;
  SetLength(FDecorrenze,0);
  SetLength(FDecorrenze,selT235.RecordCount);
  while not selT235.EOF do
  begin
    FDecorrenze[I]:=selT235.FieldByName('DECORRENZA').AsDateTime;
    if (FDecorrenze[I] <= DataPeriodo) then
      FIndiceDecorrenzaCorrente:=I;
    selT235.Next;
    Inc(I);
  end;
end;

function TA020FCausPresenzeStoricoMW.CampoInListaStorico(NomeCampo:String):Boolean;
var
  ElemListaCorrente:TA020DescrizioneElementoStorico;
begin
  Result:=False;
  for ElemListaCorrente in D_DatiStoricizzatiT235 do
  begin
    if Lowercase(ElemListaCorrente.Nome) = Lowercase(NomeCampo) then
    begin
      Result:=True;
      Break;
    end;
  end;
end;

function TA020FCausPresenzeStoricoMW.GetDescrizioneCampo(Campo:String):String;
var
  I:Integer;
begin
  Result:='';
  for I:=0 to (Length(D_DatiStoricizzatiT235) - 1) do
  begin
    if Lowercase(Campo) = Lowercase(D_DatiStoricizzatiT235[I].Nome) then
    begin
      Result:=D_DatiStoricizzatiT235[I].Descrizione;
      Break;
    end;
  end;
end;

function TA020FCausPresenzeStoricoMW.GetDescrizioneValoreCampo(Item:String;TipoDescr:TA020TipoDescrValoreCampo):String;
var
  I:Integer;
  LItem: TItemsValues;
begin
  Result:='';
  case TipoDescr of
    tdvcSiNo:
      begin
        for I:=0 to (Length(D_SiNo) - 1) do
        begin
          if Item = D_SiNo[I].Item then
          begin
            Result:=D_SiNo[I].Value;
            Break;
          end;
        end;
      end;
    tdvcConteggioTimbInterna:
      begin
        for LItem in D_ConteggioTimbInterna do
        begin
          if Item = LItem.Item then
          begin
            Result:=LItem.Value;
            Break;
          end;
        end;
      end;
    tdvcIntersezioneTimbrature:
      begin
        for LItem in D_IntersezioneTimbrature do
        begin
          if Item = LItem.Item then
          begin
            Result:=LItem.Value;
            Break;
          end;
        end;
      end;
  end;
end;

procedure TA020FCausPresenzeStoricoMW.ElaboraStoriaDati(DataPeriodo:TDateTime);
var
  I:Integer;
  ElementoListaStorico:TA020ElementoListaStorico;
  IndiceDatoCorrente:Integer;
  DataPeriodoFilterStr:String;
begin
  if FStoriaDati <> nil then
    FreeAndNil(FStoriaDati);
  if selT235.State <> dsBrowse then
    raise Exception.Create(A000MSG_A020_ERR_STORIA_T235);

  DataPeriodoFilterStr:=FloatToStr(Trunc(DataPeriodo));
  selT235.Filter:='(DECORRENZA <= ' + DataPeriodoFilterStr + ') AND (DECORRENZA_FINE >= ' + DataPeriodoFilterStr + ')';
  selT235.Filtered:=True;
  try
    if selT235.RecordCount = 0 then
      Exit
    else if selT235.RecordCount > 1 then
      raise Exception.Create(A000MSG_A020_ERR_T235_INCOERENTE)
    else
    begin
      FStoriaDati:=TObjectList<TA020ElementoListaStorico>.Create(True);
      ElementoListaStorico:=nil;
      IndiceDatoCorrente:=0;
      DataPeriodoFilterStr:=FloatToStr(Trunc(DataPeriodo));
      try
        for I:=0 to (selT235.FieldCount - 1) do
        begin
          if CampoInListaStorico(selT235.Fields[I].FieldName) then
          begin
            ElementoListaStorico:=TA020ElementoListaStorico.Create;
            StoriaDati.Add(ElementoListaStorico);
            ElementoListaStorico.Decorrenza:=selT235.FieldByName('DECORRENZA').AsDateTime;
            ElementoListaStorico.FineDecorrenza:=selT235.FieldByName('DECORRENZA_FINE').AsDateTime;
            ElementoListaStorico.ColonnaDato:=selT235.Fields[I].FieldName;
            ElementoListaStorico.Descrizione:=GetDescrizioneCampo(selT235.Fields[I].FieldName);
            ElementoListaStorico.ValoreDato:=selT235.Fields[I].AsString;
            if R180In(ElementoListaStorico.ColonnaDato,
                      ['NONABILITATA_ELIMINATIMB',
                       'NONACCOPPIATA_ANOMBLOCC',
                       'ITER_AUTSTR_ARROT_LIQ_FASCE',
                       'MATURAMENSA',
                       'TIMB_PM',
                       'TIMB_PM_H',
                       'TIMB_PM_DETRAZ',
                       'AUTOCOMPLETAMENTO_UE',
                       'SEPARA_CAUSALI_UE'
                      ]) then
              ElementoListaStorico.DescValoreDato:=GetDescrizioneValoreCampo(selT235.Fields[I].AsString,tdvcSiNo)
            else if (ElementoListaStorico.ColonnaDato = 'CONTEGGIO_TIMB_INTERNA') then
              ElementoListaStorico.DescValoreDato:=GetDescrizioneValoreCampo(selT235.Fields[I].AsString,tdvcConteggioTimbInterna)
            else if (ElementoListaStorico.ColonnaDato = 'INTERSEZIONE_TIMBRATURE') then
              ElementoListaStorico.DescValoreDato:=GetDescrizioneValoreCampo(selT235.Fields[I].AsString,tdvcIntersezioneTimbrature)
            else
              ElementoListaStorico.DescValoreDato:=selT235.Fields[I].AsString;
            ElementoListaStorico.IndiceDato:=IndiceDatoCorrente;
            inc(IndiceDatoCorrente);
          end;
        end;
      except
        on E:Exception do
        begin
          // Disalloco la lista e automaticamente gli oggetti contenuti in essa
          FreeAndNil(FStoriaDati);
          // Molto improbabile: ho allocato l'ultimo elemento ma non sono riuscito ad aggiungerlo
          // alla lista. Nel dubbio, tento di liberarlo.
          try FreeAndNil(ElementoListaStorico); except end;
          raise Exception.Create(Format(A000MSG_A020_ERR_STORIA_GEN,[E.Message]));
        end;
      end;
    end;
  finally
    selT235.Filter:='';
    selT235.Filtered:=False;
    selT235.First;
  end;
end;

procedure TA020FCausPresenzeStoricoMW.CreaRecordVuoto(ID:Integer);
begin
  insT235Nuovo.ClearVariables;
  insT235Nuovo.SetVariable('ID',ID);
  insT235Nuovo.SetVariable('DECORRENZA',DATE_MIN);
  insT235Nuovo.SetVariable('DECORRENZA_FINE',DATE_MAX);
  insT235Nuovo.SetVariable('DESCRIZIONE',DescrizioneIniziale);
  insT235Nuovo.Execute;
  insT235Nuovo.Session.Commit;
end;

procedure TA020FCausPresenzeStoricoMW.CreaCopiaParametriStorici(IDEsistente,IDNuovo:Integer);
var Colonne:String;
    i:Integer;
begin
  Colonne:='';
  for i:=0 to selT235.FieldCount - 1 do
  begin
    if (selT235.Fields[i].FieldName <> 'ID') and (selT235.Fields[i].FieldKind = fkData) then
      Colonne:=Colonne + IfThen(Colonne <> '',',') + selT235.Fields[i].FieldName;
  end;

  try
    insT235NuovoCompleto.SetVariable('ID', IDNuovo);
    insT235NuovoCompleto.SetVariable('OLD_ID', IDEsistente);
    insT235NuovoCompleto.SetVariable('COLONNE', Colonne);
    insT235NuovoCompleto.Execute;
    insT235NuovoCompleto.Session.Commit;
  except
    on E:Exception do
    begin
      raise Exception.Create(Format(A000MSG_A020_ERR_COPIA_STORIA_GEN,[E.Message]));
    end;
  end;
  // Il dataset sarà riaperto da AfterScroll sul dataset dei dati non storicizzati (selT275)
end;

procedure TA020FCausPresenzeStoricoMW.SvuotaCDSStoriaDati;
begin
  cdsStoriaParamStorizz.EmptyDataSet;
end;

procedure TA020FCausPresenzeStoricoMW.ValidazioneQueryCdzAbilitazione(SQL:String);
var
  Lst: TStringList;
  i: Integer;
begin
  if Trim(SQL) <> '' then
  begin
    selCdzAbilitazione.ClearVariables;
    selCdzAbilitazione.SQL.Clear;
    selCdzAbilitazione.SQL.Text:=Format('select (%s) from dual',[Trim(SQL)]);
    try
      try
        Lst:=FindVariables(selCdzAbilitazione.SQL.Text, False);
        if Lst.Count > 1 then
        begin
          for i := 0 to Lst.Count-1 do
          begin
            if UpperCase(Lst[i]) = 'DATA' then
            begin
              selCdzAbilitazione.DeclareVariable(Lst[i], otDate);
              selCdzAbilitazione.SetVariable(Lst[i],Date);
            end
            else if UpperCase(Lst[i]) = 'PROGRESSIVO' then
            begin
              selCdzAbilitazione.DeclareVariable(Lst[i], otInteger);
              selCdzAbilitazione.SetVariable('PROGRESSIVO',0);
            end
            else if UpperCase(Lst[i]) = 'CAUSALE' then
            begin
              selCdzAbilitazione.DeclareVariable(Lst[i], otString);
              selCdzAbilitazione.SetVariable('CAUSALE',null);
            end
            else
            begin
              raise Exception.Create(Format('"%s" non è una variabile valida in questo contesto. Le variabili ammesse sono: PROGRESSIVO, DATA, e CAUSALE', [Lst[i]]));
            end;
          end;
        end;
      finally
        Lst.Free;
      end;
      selCdzAbilitazione.Execute;
    except
      on E:Exception do
        raise Exception.Create('Condizione abilitazione: query errata' + #13#10 + E.Message);
    end;
  end;
end;

procedure TA020FCausPresenzeStoricoMW.ValorizzaCDSStoriaDati;
var
  Elemento:TA020ElementoListaStorico;
begin
  cdsStoriaParamStorizz.EmptyDataSet;
  if (StoriaDati <> nil) then
  begin
    for Elemento in StoriaDati do
    begin
      cdsStoriaParamStorizz.Append;
      cdsStoriaParamStorizz.FieldByName('DATO').AsString:=Elemento.Descrizione;
      cdsStoriaParamStorizz.FieldByName('DECORRENZA').AsString:=FormatDateTime('dd/mm/yyyy',Elemento.Decorrenza);
      cdsStoriaParamStorizz.FieldByName('FINE_DECORRENZA').AsString:=FormatDateTime('dd/mm/yyyy',Elemento.FineDecorrenza);
      cdsStoriaParamStorizz.FieldByName('VALORE').AsString:=Elemento.DescValoreDato;
      cdsStoriaParamStorizz.Post;
    end;
  end;
end;

end.
