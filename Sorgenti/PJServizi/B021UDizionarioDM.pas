unit B021UDizionarioDM;

interface

uses
  DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} A000UCostanti, A000USessione, C180FunzioniGenerali,
  R014URestDM, B021UIrisRestSvcDM, C200UWebServicesTypes, B021UUtils,
  Generics.Collections, Oracle, DB, OracleData, StrUtils,
  SysUtils, Variants, Classes, Math;

type
  TDataStorica = record
    Campo: String;
    Alias: String;
    Formato: String;
  end;

  TTipoDati = record
    Dato: String;
    Conv: String;
  end;

  TB021FDizionarioDM = class(TR014FRestDM)
    selIA110: TOracleDataSet;
    selDizionario: TOracleDataSet;
  private
    Struttura: String;
    Tabella: String;
    FParametri: String;
    Page: Integer;
    Per_page: Integer;
    Url: String;
    Elenco: String;
    CampoDecorrenza: String;
    CampoScadenza: String;
    Paginazione: Boolean;
    function  CheckParam(const Par, Val: String; var Errore: String): Boolean;
    function ParseParametri(const PParametri: String): String;
    procedure LeggiStruttura;
    function  GetDizionario: TJSONObject;
    function  GetLinkPaginazione(page_count, total_count: Integer): TJSONArray;
  protected
    function ControlloParametri(var RErrMsg: String): Boolean; override;
  public
    function GetDato: TJSONObject; override;
  end;

implementation

{$R *.dfm}

procedure TB021FDizionarioDM.LeggiStruttura;
var
  Intestazione, T, Campo, NomeDato, CampoFmt: String;
const
  NOME_PROC = 'LeggiStruttura';
begin
  CampoDecorrenza:='';
  CampoScadenza:='';
  Log(NOME_PROC,Format('%s: inizio lettura della struttura',[Struttura]));

  // lettura struttura dizionario
  selIA110.Close;
  selIA110.SetVariable('AZIENDA',TSessioneIrisWIN(Self.Owner).Parametri.Azienda);
  selIA110.SetVariable('NOME_STRUTTURA',Struttura);
  Log(NOME_PROC,Format('apertura dataset per azienda [%s], struttura [%s]',[TSessioneIrisWIN(Self.Owner).Parametri.Azienda,Struttura]));
  selIA110.Open;
  Log(NOME_PROC,Format('apertura dataset riuscita (%d record)',[selIA110.RecordCount]));
  if selIA110.RecordCount = 0 then
  begin
    Log(NOME_PROC,Format('struttura [%s] non presente',[Struttura]));
    raise EB021InvalidStructure.Create(Format('Struttura [%s]: inesistente',[Struttura]))
  end;

  while not selIA110.Eof do
  begin
    Intestazione:=selIA110.FieldByName('INTESTAZIONE').AsString;
    NomeDato:=selIA110.FieldByName('NOME_DATO').AsString;
    T:=selIA110.FieldByName('TABELLA').AsString;
    if Tabella = '' then
      Tabella:=T
    else if T <> Tabella then
      raise EB021InvalidStructure.Create(Format('Struttura [%s]: è previsto l''utilizzo di una singola tabella / vista',[Struttura]));

    // nome del campo
    Campo:=selIA110.FieldByName('CAMPO').AsString;
    if Intestazione = 'DECORRENZA' then
      CampoDecorrenza:=Campo;
    if Intestazione = 'SCADENZA' then
      CampoScadenza:=Campo;

    // al momento i campi con posizione non indicata vengono esclusi
    if not selIA110.FieldByName('POS_DATO').IsNull then
    begin
      // formattazione del campo
      if (selIA110.FieldByName('TIPO_DATO').AsString = 'D') and
         (not selIA110.FieldByName('FMT_DATA').IsNull) then
        CampoFmt:=Format('to_char(%s,''%s'') %s',[Campo,selIA110.FieldByName('FMT_DATA').AsString,Campo])
      else
        CampoFmt:=Campo;

      // elenco dei campi da selezionare
      Elenco:=Elenco + CampoFmt + ',';
    end;
    selIA110.Next;
  end;

  if Elenco <> '' then
    Elenco:=Copy(Elenco,1,Length(Elenco) - 1)
end;

function TB021FDizionarioDM.CheckParam(const Par, Val: String; var Errore: String): Boolean;
var
  DataTemp: TDateTime;
begin
  Result:=True;
  try
    if Par = 'MATRICOLA' then
    begin
      // matricola: verifica esistenza
      selProg.SetVariable('MATRICOLA',Val);
      selProg.Execute;
      Result:=selProg.RowCount > 0;
      if not Result then
        Errore:=Format('Matricola inesistente: %s',[Val]);
    end
    else if Par = 'DATA' then
    begin
      // data
      Result:=TB021FUtils.ConvertiStrDate(Val,DataTemp);
      if not Result then
        Errore:='Data non valida: formato non valido';
    end;
  except
    on E: Exception do
    begin
      Result:=False;
      Errore:=Format('%s non valido: %s (%s)',[Par,Val,E.Message]);
    end;
  end;
end;

function TB021FDizionarioDM.ParseParametri(const PParametri: String): String;
// parsifica i parametri passati al webservice e li trasforma in un filtro SQL
// utilizzabile per filtrare i record richiesti
var
  i,p: Integer;
  ParList: TStringList;
  S, Parametro, Valore, Err, FiltroSingolo: String;
begin
  Result:='';

  if PParametri <> '' then
  begin
    // utilizza una stringlist per estrarre le coppie di parametri
    ParList:=TStringList.Create;
    try
      ParList.Delimiter:='&';
      ParList.StrictDelimiter:=True;
      ParList.DelimitedText:=PParametri;
      for i:=0 to ParList.Count - 1 do
      begin
        S:=ParList[i];
        p:=Pos('=',S);
        Parametro:=Copy(S,1,p - 1);
        Valore:=Copy(S,p + 1);
        FiltroSingolo:='';
        if (CampoDecorrenza <> '') and (CampoScadenza <> '') and (Parametro.ToUpper = 'DATA') then
          FiltroSingolo:=Format('to_date(''%s'',''dd-mm-yyyy'') between %s and %s',[Valore,CampoDecorrenza,CampoScadenza])
        else
          FiltroSingolo:=Format('%s = ''%s''',[Parametro,Valore]);

        // controllo parametro
        if not CheckParam(Parametro.ToUpper,Valore,Err) then
          raise EC200InvalidParameter.Create(Err);

        // gestione particolare vista
        if (Tabella.ToUpper = 'USR_VT265_FIRLAB') and (Parametro.ToUpper = 'MATRICOLA') then
          FiltroSingolo:=Format('((%s) or (%s is null))',[FiltroSingolo,Parametro]);

        Result:=Result + IfThen(Result <> '', ' AND ') + FiltroSingolo;
      end;
      if Result <> '' then
        Result:='WHERE ' + Result;
    finally
      FreeAndNil(ParList);
    end;
  end;
end;

function TB021FDizionarioDM.GetDizionario: TJSONObject;
var
  i: Integer;
  Campo,Alias,Filtro,Fmt: String;
  ResArr: TJSONArray;
  Element: TJSONObject;
  // COMO_HSANNA - commessa 2013/012 SVILUPPO#6.ini
  Dict: TDictionary<String,String>;
  Key: String;
  // COMO_HSANNA - commessa 2013/012 SVILUPPO#6.ini
  page_count,total_count: Integer;
  inizioPagina,finePagina: Integer;
const
  NOME_PROC = 'GetDizionario';
begin
  Log(NOME_PROC,Format('struttura [%s]: estrazione dati',[Struttura]));
  // dati della tabella dizionario
  if Elenco = '' then
    raise EB021InvalidStructure.Create(Format('Struttura [%s]: nessun dato da estrarre',[Struttura]))
  else
  begin
    Filtro:=ParseParametri(FParametri);
    ResArr:=TJSONArray.Create;
    page_count:=-1;
    total_count:=-1;
    finePagina:=-1;

    selDizionario.Close;
    selDizionario.ClearVariables;
    selDizionario.SetVariable('ELENCO_CAMPI',Elenco);
    selDizionario.SetVariable('TABELLA',Tabella);
    selDizionario.SetVariable('ORDINAMENTO','ORDER BY 1');
    // filtro / ordinamento per prima apertura dataset
    if Filtro <> '' then
      selDizionario.SetVariable('FILTRO','WHERE ROWNUM < 0');

    // ulteriore apertura dataset per verificare eventuali errori nei campi / tabella
    try
      selDizionario.Open;
    except
      on E: Exception do
        raise EB021InvalidStructure.Create(Format('Struttura [%s]: errore nella selezione dei dati: %s',[Struttura,E.Message]));
    end;
    // se è indicato un filtro effettua una seconda apertura del dataset
    // in modo da dare una segnalazione precisa in caso di errore
    if Filtro <> '' then
    begin
      R180SetVariable(selDizionario,'FILTRO',Filtro);
      try
        selDizionario.Open;
      except
        on E: Exception do
          raise EC200InvalidParameter.Create(Format('Struttura [%s]: errore nel parametro di filtro dei dati [%s]: %s',[Struttura,FParametri,E.Message]));
      end;
    end;

    Log(NOME_PROC,Format('%d record estratti',[selDizionario.RecordCount]));

    //se è attiva la paginazione, calcolo i parametri richiesti
    if Paginazione then
    begin
      total_count:=selDizionario.RecordCount;
      page_count:=Ceil(total_count/Per_page);

      //è richiesta una pagina non esistente, con esclusione della prima pagina vuota
      //(se non ci sono record mostro comunque la pagina 0 vuota)
      if (Page > page_count-1) and (Page <> 0) then
        raise EC200InvalidParameter.Create('Parametri di paginazione non validi');

      inizioPagina:=(Page*Per_page)+1;
      finePagina:=inizioPagina+Per_page-1;

      if inizioPagina > selDizionario.RecordCount then
        selDizionario.Last
      else
        selDizionario.RecNo:=inizioPagina;
    end;

    while not selDizionario.Eof do
    begin
      Element:=TJSONObject.Create;

      // aggiunge le coppie nome campo / valore al risultato
      for i:=0 to selDizionario.FieldCount - 1 do
      begin
        Campo:=selDizionario.Fields[i].FieldName;
        Alias:=VarToStr(selIA110.Lookup('CAMPO',Campo,'NOME_DATO'));
        Fmt:=VarToStr(selIA110.Lookup('CAMPO',Campo,'TIPO_DATO'));
        if Alias = '' then
          Alias:=Campo;
        if (Fmt = 'A') or (Fmt = 'D') then
        begin
          // valore string
          Element.AddPair(Alias,TJSONString.Create(selDizionario.Fields[i].AsString));
        end
        else if Fmt = 'N' then
        begin
          // valore numerico
          Element.AddPair(Alias,TJSONNumber.Create(selDizionario.Fields[i].AsFloat))
        end
        else if Fmt = 'B' then
        begin
          // valore boolean
          if R180In(selDizionario.Fields[i].AsString,['s','S','1']) then
            Element.AddPair(Alias,TJSONTrue.Create)
          else
            Element.AddPair(Alias,TJSONFalse.Create);
        end;
      end;

      ResArr.Add(Element);

      selDizionario.Next;

      //se attiva la paginazione e sono a fine pagina, esco dal ciclo
      if Paginazione and (selDizionario.RecNo > finePagina) then
        break;
    end;
    selDizionario.Close;

    // COMO_HSANNA - commessa 2013/012 SVILUPPO#6.ini
    //Result:=TJSONObject.Create(TJSONPair.Create(Struttura.ToLower,ResArr));
    Result:=TJSONObject.Create;
    // sono aggiunti due nuovi dati fissi: esito e timestamp
    Result.AddPair('esito',TJSONString.Create('OK'));
    Result.AddPair('timestamp',TJSONString.Create(TB021FUtils.ConvertiDateTimeStr(Now)));

    //se attiva la paginazione aggiungo gli elementi richiesti alla risposta
    if Paginazione then
    begin
      Result.AddPair('page',TJSONNumber.Create(Page));
      Result.AddPair('per_page',TJSONNumber.Create(Per_page));
      Result.AddPair('page_count',TJSONNumber.Create(page_count));
      Result.AddPair('total_count',TJSONNumber.Create(total_count));
      Result.AddPair('links', GetLinkPaginazione(page_count, total_count));
    end;

    Dict:=TB021FUtils.GetQuerystringParams(FParametri);
    try
      for Key in Dict.Keys do
        Result.AddPair(Key,TJSONString.Create(Dict.Items[Key]));
    finally
      FreeAndNil(Dict);
    end;
    // struttura dizionario
    Result.AddPair(Struttura.ToLower,ResArr);
    // COMO_HSANNA - commessa 2013/012 SVILUPPO#6.fine
  end;
  selIA110.Close;
end;

function TB021FDizionarioDM.GetLinkPaginazione(page_count, total_count: Integer): TJSONArray;
begin
  Result:=TJSONArray.Create;
  Result.Add(TJSONObject.Create(TJSONPair.Create('self',TJSONString.Create(Format(Url,[Page,Per_page])))));
  if page_count > 1 then //se ho più di una pagina inserisco first e last
  begin
    Result.Add(TJSONObject.Create(TJSONPair.Create('first',TJSONString.Create(Format(Url,[0,Per_page])))));
    Result.Add(TJSONObject.Create(TJSONPair.Create('last',TJSONString.Create(Format(Url,[page_count-1,Per_page])))));
  end;
  if Page > 0 then       //dalla 2^ pagina in poi inserisco previous
    Result.Add(TJSONObject.Create(TJSONPair.Create('previous',TJSONString.Create(Format(Url,[Page-1,Per_page])))));
  if (page_count > 1) and (Page < page_count-1) then
    Result.Add(TJSONObject.Create(TJSONPair.Create('next',TJSONString.Create(Format(Url,[Page+1, Per_page])))));
end;

function TB021FDizionarioDM.ControlloParametri(var RErrMsg: String): Boolean;
var sPage,sPerPage: String;
begin
  RErrMsg:='';
  Result:=False;
  Paginazione:=False;
  Page:=-1;
  Per_page:=-1;

  Struttura:=GetParam('struttura');
  FParametri:=GetParam('parametri');

  if Trim(Struttura) = '' then
  begin
    RErrMsg:='Parametro [struttura] non indicato';
    Exit;
  end;

  //validazione parametri per paginazione
  Url:=GetParam('url');
  sPage:=GetParam('page');
  sPerPage:=GetParam('per_page');
  if (sPage <> '') or (sPerPage <> '') then
  begin
    if not (TryStrToInt(sPage,Page) and TryStrToInt(sPerPage,Per_page)) then
    begin
      RErrMsg:='Parametri di paginazione non validi';
      Exit;
    end;
    if (Page < 0) or (Per_page <= 0) then
    begin
      RErrMsg:='Parametri di paginazione non validi';
      Exit;
    end
    else
    begin
      Url:=Url+'?page=%d&per_page=%d';
      Paginazione:=True;
    end;
  end;

  Result:=True;
end;

function TB021FDizionarioDM.GetDato: TJSONObject;
begin
  LeggiStruttura;
  Result:=GetDizionario;
end;

end.
