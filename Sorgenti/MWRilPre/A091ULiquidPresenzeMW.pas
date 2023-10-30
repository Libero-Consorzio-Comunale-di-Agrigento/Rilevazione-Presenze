unit A091ULiquidPresenzeMW;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  A000UMessaggi,
  A000USessione,
  A029ULiquidazione,
  C180FunzioniGenerali,
  DatiBloccati,
  FunzioniGenerali,
  R005UDataModuleMW,
  R450,
  USelI010,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, DBClient,  Oracle, Math, System.StrUtils;

type
  TA091FLiquidPresenzeMW = class(TR005FDataModuleMW)
    dsrT275: TDataSource;
    selT275: TOracleDataSet;
    TabellaStampa: TClientDataSet;
    QCols: TOracleDataSet;
    insT073: TOracleQuery;
    insT074: TOracleQuery;
    updT073: TOracleQuery;
    updT074: TOracleQuery;
    updT073_T074: TOracleQuery;
    selT074: TOracleQuery;
    procedure selT275FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure TabellaStampaBeforePost(DataSet: TDataSet);
  private
    selI010: TselI010;
    IdRiga: Integer;
    selDatiBloccati: TDatiBloccati;
    procedure InserisciRecord(Causale: String; Data: TDateTime; MaxLiq, ArrLiq, MaxComp, ArrComp, TipoDisponibilita: Integer; Aggiornamento: Boolean);
    procedure ImpostaCampiTabellaStampaReadonly(const PReadonly: Boolean);
    const
      COD_RIEPILOGO = 'T074';
  public
    R450DtM1:TR450DtM1;
    A029FLiquidazione: TA029FLiquidazione;

    LstCampiAnagrafe: TStringList;
    DNomeCampo:TStringList;
    DNomeLogico:TStringList;
    INomeCampo:TStringList;
    INomeLogico:TStringList;

    function SettaIntestazioneDettaglio(SqlSelAnagrafe: String; LstIntestazione, LstDettaglio: TStringList): String;
    procedure LiquidazionePresenza(const PModalitaSimulazione: Boolean;Progressivo: Integer; Data: TDateTime; Causale: String; Liquidato,Compensabile, TipoDisponibilita: Integer);
    procedure CreaTabellaStampa(const OrdinaDettaglio:boolean=False);
    procedure InizializzaDatiBloccati;
    function DatoBloccato(Progressivo: Integer; Data: TDateTime): Boolean;
    procedure ElaboraDipendente(LstCodCausali: TStringList; Anno, Mese, MaxLiq, ArrLiq, MaxComp, ArrComp, TipoDisponibilita: Integer; Aggiornamento: Boolean);
    procedure PreparaAggiornaFruitoBudget(Data: TDateTime);

    function GetDataUltimaLiquidazioneAnno(PDataRif: TDateTime;PCausale: String; PLiquidazioni,PCompensazioni:Boolean) :TDateTime;
    procedure ImpostaVarAnnulla(PData: TDateTime; PElencoCausali: String; PLiquidazioni, PCompensazioni: Boolean);
    procedure AnnullaLiquidazione(PData: TDateTime; PElencoCausali: String);
    procedure LiquidazioneDatiModificati(Anno,Mese,TipoDisponibilita,IdRiga: Integer);
  end;

implementation

{$R *.dfm}

procedure TA091FLiquidPresenzeMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO','','NOME_LOGICO');
  selT275.Open;
  QCols.Open;
  R450DtM1:=TR450DtM1.Create(nil);
  A029FLiquidazione:=TA029FLiquidazione.Create(nil);
  A029FLiquidazione.R450DtM:=R450DtM1;
  selDatiBloccati:=TDatiBloccati.Create(Self);
  TipoModulo:=TTipoModuloRec.ClientServer;

  INomeCampo:=TStringList.Create;
  INomeLogico:=TStringList.Create;
  DNomeCampo:=TStringList.Create;
  DNomeLogico:=TStringList.Create;
  LstCampiAnagrafe:=TStringList.Create;

  selI010.First;
  while not selI010.Eof do
  begin
    if (Copy(selI010.FieldByname('NOME_CAMPO').AsString,1,6) <> 'T430D_') and
       (selI010.FieldByname('NOME_CAMPO').AsString <> 'COGNOME') and
       (selI010.FieldByname('NOME_CAMPO').AsString <> 'NOME') and
       (selI010.FieldByname('NOME_CAMPO').AsString <> 'MATRICOLA') then
      LstCampiAnagrafe.Add(selI010.FieldByname('NOME_LOGICO').AsString);
    selI010.Next;
  end;
end;

procedure TA091FLiquidPresenzeMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(selI010);
  FreeAndNil(INomeCampo);
  FreeAndNil(INomeLogico);
  FreeAndNil(DNomeCampo);
  FreeAndNil(DNomeLogico);
  FreeAndNil(LstCampiAnagrafe);
  TabellaStampa.Close;
  FreeAndNil(R450DtM1);//.Free;
  FreeAndNil(A029FLiquidazione);
  FreeAndNil(selDatiBloccati);
  inherited;
end;

procedure TA091FLiquidPresenzeMW.selT275FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('CAUSALI PRESENZA',DataSet.FieldByName('CODICE').AsString);
end;

function TA091FLiquidPresenzeMW.SettaIntestazioneDettaglio(SqlSelAnagrafe: String;LstIntestazione, LstDettaglio: TStringList): String;
var
  C,D_C,S:String;
  i:Integer;
  LCambioSelAnagrafe: Boolean;
begin
  Result:='';
  LCambioSelAnagrafe:=False;
  S:=SqlSelAnagrafe;
  INomeCampo.Clear;
  INomeLogico.Clear;
  DNomeCampo.Clear;
  DNomeLogico.Clear;
  for i:=0 to LstIntestazione.Count - 1 do
  begin
    C:=LstIntestazione[i];
    D_C:=VarToStr(selI010.Lookup('NOME_LOGICO',C,'NOME_CAMPO'));
    INomeCampo.Add(D_C);
    INomeLogico.Add(C);
    if R180InserisciColonna(S,D_C) then
      LCambioSelAnagrafe:=True;

    Insert('D_',D_C,5);
    if selI010.Locate('NOME_CAMPO',D_C,[]) then
    begin
      if R180InserisciColonna(S,D_C) then
        LCambioSelAnagrafe:=True;
    end;
  end;

  for i:=0 to LstDettaglio.Count - 1 do
  begin
    C:=LstDettaglio[i];
    D_C:=VarToStr(selI010.Lookup('NOME_LOGICO',C,'NOME_CAMPO'));
    DNomeCampo.Add(D_C);
    DNomeLogico.Add(C);
    if R180InserisciColonna(S,D_C) then
      LCambioSelAnagrafe:=True;
  end;

  if LCambioSelAnagrafe then //se selanagrafe cambiata; restituisco nuova selezione
    Result:=S;
end;

procedure TA091FLiquidPresenzeMW.TabellaStampaBeforePost(DataSet: TDataSet);
var
  LNominativo,LCausale,LInfoRiga,LLiquidato,LLiquidatoDisp: String;
  LLiquidatoM, LLiquidatoDispM: Integer;
begin
  inherited;

  // salva informazioni in variabili di appoggio
  LNominativo:=TabellaStampa.FieldByName('CognomeNome').AsString;
  LCausale:=TabellaStampa.FieldByName('Causale').AsString;
  LInfoRiga:=Format('%s (causale %s)',[LNominativo,LCausale]);
  LLiquidato:=TabellaStampa.FieldByName('Liquidato').AsString;
  LLiquidatoDisp:=TabellaStampa.FieldByName('Liquidato_Disp').AsString;

  // controlla che il liquidato sia indicato
  if (LLiquidato.Trim = '') then
    raise Exception.Create(Format('Indicare la quantità da liquidare per il dipendente'#13#10'%s',[LInfoRiga]));

  // controlla che il liquidato non superi la quantità disponibile
  LLiquidatoM:=R180OreMinutiExt(LLiquidato);
  LLiquidatoDispM:=R180OreMinutiExt(LLiquidatoDisp);
  if LLiquidatoM > LLiquidatoDispM then
    raise Exception.Create(Format('La quantità da liquidare per il dipendente'#13#10'%s'#13#10'supera la disponibilità:'#13#10'[%s] > [%s]',[LInfoRiga,LLiquidato,LLiquidatoDisp]));
end;

//per WebPJ OrdinaDettaglio a True
procedure TA091FLiquidPresenzeMW.CreaTabellaStampa(const OrdinaDettaglio:boolean=False);
var Chiave,D_C:String;
    i,L:Integer;
begin
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;

  Chiave:='';
  for i:=0 to INomeCampo.Count - 1 do
  begin
    D_C:=INomeCampo[i];
    if QCols.Locate('COLUMN_NAME',D_C,[]) then
    begin
      L:=QCols.FieldByName('DATA_LENGTH').AsInteger;
      if Chiave <> '' then
        Chiave:=Chiave + ';';
      Chiave:=Chiave + D_C;
      try
        TabellaStampa.FieldDefs.Add(D_C,ftString,L,False);
      except
      end;
    end;
    Insert('D_',D_C,5);
    try
      TabellaStampa.FieldDefs.Add(D_C,ftString,40,False);
    except
    end;
  end;
  for i:=0 to DNomeCampo.Count - 1 do
  begin
    D_C:=DNomeCampo[i];
    if QCols.Locate('COLUMN_NAME',D_C,[]) then
    begin
      if OrdinaDettaglio then
      begin
        if Chiave <> '' then
          Chiave:=Chiave + ';';
        Chiave:=Chiave + D_C;
      end;

      L:=QCols.FieldByName('DATA_LENGTH').AsInteger;
      try
        TabellaStampa.FieldDefs.Add(D_C,ftString,L,False);
      except
      end;
    end;
  end;

  try
    TabellaStampa.FieldDefs.Add('IdRiga',ftInteger);
  except
  end;
  //Caratto 08/7/2013 Mettendo prima i campi di dettaglio per griglia web
  //devo aggiungere la gestione di errore in caso il campo sia già presente
  try
    TabellaStampa.FieldDefs.Add('Progressivo',ftInteger,0,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Matricola',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('CognomeNome',ftString,60,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Badge',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Liquidabile',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Liquidato_Disp',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Liquidato',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Residuo',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Compensabile',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Riporto',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Anomalia',ftString,1,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Causale',ftString,5,False);
  except
  end;

  if Chiave <> '' then
    Chiave:=Chiave + ';';
  Chiave:=Chiave + 'CognomeNome;Matricola;Causale';
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Primario',('Progressivo;Causale'),[ixUnique]);
  TabellaStampa.IndexDefs.Add('Secondario',(Chiave),[]);
  TabellaStampa.CreateDataSet;
  TabellaStampa.LogChanges:=False;
  TabellaStampa.IndexName:='Secondario';
  //display label per webPJ
  for i:=0 to DNomeCampo.Count - 1 do
  begin
    try
      TabellaStampa.FieldByName(DNomeCampo[i]).DisplayLabel:=R180Capitalize(DNomeLogico[i]);
    except
    end;
  end;

  ImpostaCampiTabellaStampaReadonly(True);

  TabellaStampa.FieldByName('IdRiga').Visible:=(DebugHook <> 0);
  TabellaStampa.FieldByName('IdRiga').DisplayLabel:='ID riga (**)';
  TabellaStampa.FieldByName('Progressivo').Visible:=False;
  TabellaStampa.FieldByName('CognomeNome').DisplayLabel:='Nominativo';
  TabellaStampa.FieldByName('Badge').Visible:=False;
  TabellaStampa.FieldByName('Liquidabile').DisplayLabel:='Liquidabile teorico';
  TabellaStampa.FieldByName('Liquidato_Disp').DisplayLabel:='Liquidabile disp.';
  TabellaStampa.FieldByName('Liquidato').EditMask:='!900:00;1;_';
end;

procedure TA091FLiquidPresenzeMW.ImpostaCampiTabellaStampaReadonly(const PReadonly: Boolean);
var
  i: Integer;
begin
  // imposta il readonly dei campi come da parametro
  for i:=0 to TabellaStampa.Fields.Count - 1 do
    TabellaStampa.Fields[i].ReadOnly:=PReadonly;

  // il campo "Liquidato" è sempre modificabile
  TabellaStampa.FieldByName('Liquidato').ReadOnly:=False;
end;

//TipoDisponibilita 0 = mensile ; 1 = annuale
procedure TA091FLiquidPresenzeMW.LiquidazionePresenza(const PModalitaSimulazione: Boolean; Progressivo:Integer; Data:TDateTime; Causale:String; Liquidato,Compensabile,TipoDisponibilita:Integer);
{Liquidazione delle ore indicate}
var i,k,h,Comodo:Integer;
begin
  if PModalitaSimulazione then
  begin
    // pulisce la struttura dati
    A029FLiquidazione.A029FBudgetDtM1.CtrlLiqClear;
  end
  else
  begin
    // modalità effettiva
    R450DtM1.selT073.Filtered:=False;

    // se non esiste il record su T073 lo aggiunge
    if not R450DtM1.selT073.SearchRecord('Causale;Data',VarArrayOf([Causale,Data]),[srFromBeginning]) then
    begin
      insT073.SetVariable('Progressivo',Progressivo);
      insT073.SetVariable('Data',Data);
      insT073.SetVariable('Causale',Causale);
      insT073.Execute;

      insT074.SetVariable('Progressivo',Progressivo);
      insT074.SetVariable('Data',Data);
      insT074.SetVariable('Causale',Causale);
      for i:=1 to R450DtM1.NFasceMese do
      begin
        insT074.SetVariable('Maggiorazione',R450DtM1.tmaggioraz[i]);
        insT074.SetVariable('CodFascia',R450DtM1.tfasce[i]);
        try
          insT074.Execute;
        except
        end;
      end;
    end;
  end;

  // indice causale
  k:=R450DtM1.IndiceRiepPres(Causale);

  // compensabile (T073)
  if not PModalitaSimulazione then
  begin
    if Compensabile > 0 then
    begin
      updT073.SetVariable('Progressivo',Progressivo);
      updT073.SetVariable('Data',Data);
      updT073.SetVariable('Causale',Causale);
      updT073.SetVariable('Compensabile',R180MinutiOre(Compensabile + R450DtM1.RiepPres[k].CompensabileMese));
      updT073.Execute;
    end;
  end;

  // liquidato (T074)
  if Liquidato > 0 then
  begin
    if not PModalitaSimulazione then
    begin
      updT074.SetVariable('Progressivo',Progressivo);
      updT074.SetVariable('Data',Data);
      updT074.SetVariable('Causale',Causale);
    end;
    for i:=R450DtM1.NFasceMese downto 1 do
    begin
      if Liquidato = 0 then
        Break;
      if TipoDisponibilita = 0 then
        h:=Max(0,R450DtM1.RiepPres[k].OreReseMese[i] - R450DtM1.RiepPres[k].LiquidatoMese[i])
      else
        h:=Max(0,R450DtM1.RiepPres[k].Liquidabile[i] - R450DtM1.RiepPres[k].Liquidato[i]);
      if Liquidato > h then
        Comodo:=h
      else
        Comodo:=Liquidato;
      dec(Liquidato,Comodo);
      if Comodo > 0 then
      begin
        if PModalitaSimulazione then
        begin
          // in modalità simulazione carica la struttura dati per calcolare l'importo corrispondente
          A029FLiquidazione.A029FBudgetDtM1.CtrlLiqAdd(Causale,R450DtM1.tmaggioraz[i],Comodo + R450DtM1.RiepPres[k].LiquidatoMese[i]);
        end
        else
        begin
          // aggiorna la T074 in modalità effettiva
          updT074.SetVariable('Maggiorazione',R450DtM1.tmaggioraz[i]);
          updT074.SetVariable('CodFascia',R450DtM1.tfasce[i]);
          updT074.SetVariable('Liquidato',R180MinutiOre(Comodo + R450DtM1.RiepPres[k].LiquidatoMese[i]));
          updT074.Execute;
        end;
      end;
    end;
  end;

  // in modalità effettiva esegue commit e rimuove il filtro al dataset selT073
  if not PModalitaSimulazione then
  begin
    SessioneOracle.Commit;
    R450DtM1.selT073.Filtered:=True;
  end;
end;

function TA091FLiquidPresenzeMW.DatoBloccato(Progressivo: Integer; Data: TDateTime): Boolean;
begin
  Result:=selDatiBloccati.DatoBloccato(Progressivo,R180InizioMese(Data),COD_RIEPILOGO);
end;

procedure TA091FLiquidPresenzeMW.ElaboraDipendente(LstCodCausali: TStringList;Anno,Mese,MaxLiq,ArrLiq,MaxComp,ArrComp,TipoDisponibilita:Integer;Aggiornamento: Boolean);
var
  i,MaxCompCau, ArrCompCau: Integer;
  Data: TDateTime;
begin
  Data:=EncodeDate(Anno,Mese,1);
  for i:=0 to LstCodCausali.Count - 1 do
  begin
    R450DtM1.ConteggiMese('Generico',Anno,Mese,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    if (R450DtM1.ttrovscheda[Mese] = 1) then
    begin
      //Danilo 19/09/2007 Gestione della compensazione se causale esclusa dalle ore normali
      MaxCompCau:=0;
      ArrCompCau:=0;
      if VarToStr(selT275.Lookup('CODICE',Trim(LstCodCausali[i]),'ORENORMALI')) = 'A' then
      begin
        MaxCompCau:=MaxComp;
        ArrCompCau:=ArrComp;
      end;
      InserisciRecord(Trim(LstCodCausali[i]),Data,MaxLiq,ArrLiq,MaxCompCau,ArrCompCau,TipoDisponibilita,Aggiornamento);
    end;
  end;
end;

procedure TA091FLiquidPresenzeMW.InizializzaDatiBloccati;
begin
  selDatiBloccati.Close;
end;

procedure TA091FLiquidPresenzeMW.InserisciRecord(Causale:String;Data: TDateTime;MaxLiq,ArrLiq,MaxComp,ArrComp,TipoDisponibilita: Integer;Aggiornamento: Boolean);
var D_C,S:string;
    i,k,Liquidabile,Liquidato,LiquidatoMese,
    Residuo,ResiduoTot,Compensabile,
    Riporto: Integer;
    ImpLiq: Real;
    LRiepBloccato,Esegui: Boolean;
begin
  k:=R450DtM1.IndiceRiepPres(Causale);
  if k = -1 then
    exit;

  ImpostaCampiTabellaStampaReadonly(False);

  TabellaStampa.Insert;
  TabellaStampa.FieldByName('Badge').Value:=SelAnagrafe.FieldByName('T430Badge').Value;
  TabellaStampa.FieldByName('CognomeNome').Value:=SelAnagrafe.FieldByName('Cognome').Value+' '+SelAnagrafe.FieldByName('Nome').Value;
  TabellaStampa.FieldByName('Matricola').Value:=SelAnagrafe.FieldByName('Matricola').Value;
  TabellaStampa.FieldByName('Progressivo').Value:=SelAnagrafe.FieldByName('Progressivo').Value;
  TabellaStampa.FieldByName('Anomalia').AsString:='';
  TabellaStampa.FieldByName('Causale').Value:=Causale;
  for i:=0 to INomeCampo.Count - 1 do
  begin
    D_C:=INomeCampo[i];
    S:=Format('%-*s',[SelAnagrafe.FieldByName(D_C).Size,SelAnagrafe.FieldByName(D_C).AsString]);
    TabellaStampa.FieldByName(D_C).AsString:=S;
    Insert('D_',D_C,5);
    try
      // gestione campo non esistente
      if SelAnagrafe.FindField(D_C) <> nil then
        TabellaStampa.FieldByName(D_C).AsString:=SelAnagrafe.FieldByName(D_C).AsString;
    except
    end;
  end;
  for i:=0 to DNomeCampo.Count - 1 do
  begin
    TabellaStampa.FieldByName(DNomeCampo[i]).AsString:=SelAnagrafe.FieldByName(DNomeCampo[i]).AsString;
  end;

  Liquidabile:=0;
  Liquidato:=0;
  LiquidatoMese:=0;
  Residuo:=0;
  ResiduoTot:=0;
  Compensabile:=0;
  Riporto:=0;
  for i:=1 to R450DtM1.NFasceMese do
  begin
    //Alberto 19/06/2008: Limite della disponibilità al residuo calcolato da R450
    if TipoDisponibilita = 0 then
      inc(Liquidabile,R450DtM1.RiepPres[k].OreReseMese[i] - R450DtM1.RiepPres[k].LiquidatoMese[i])
    else
      inc(Liquidabile,min(R450DtM1.RiepPres[k].Residuo[i],R450DtM1.RiepPres[k].Liquidabile[i] - R450DtM1.RiepPres[k].Liquidato[i]));
    inc(LiquidatoMese,R450DtM1.RiepPres[k].LiquidatoMese[i]);
    inc(ResiduoTot,R450DtM1.RiepPres[k].Residuo[i]);
  end;
  if TipoDisponibilita = 0 then
    Liquidabile:=min(ResiduoTot,Liquidabile - R450DtM1.RiepPres[k].CompensabileMeseEff);
  Liquidabile:=Max(0,Liquidabile);
  //Alberto 23/02/2006: gestione delle causali incluse nelle normali
  if VarToStr(selT275.Lookup('CODICE',Causale,'ORENORMALI')) <> 'A' then
    Liquidabile:=Min(Liquidabile,R450DtM1.StrResiduoAnno);
  //Non ci devono essere liquidazioni successive
  if R450DtM1.EsistePresenzaLiquidataSuccessiva(Causale) then
  begin
    if Liquidabile > 0 then
    begin
      TabellaStampa.FieldByName('Anomalia').AsString:='X';
      RegistraMsg.InserisciMessaggio('A','Esiste liquidazione successiva',Parametri.Azienda,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    end;
  end
  else
  begin
    //Liquidabile = ore residue disponibili per la liquidazione/compensazione
    Liquidato:=Max(0,Liquidabile);
    if Liquidato > (MaxLiq - LiquidatoMese) then
      Liquidato:=Max(0,MaxLiq - LiquidatoMese);
    //Controllo straordinario autorizzato annuo se l'uso del budget non è impostato
    //ad 'L'(ossia Libero di sforare) e la causale abbatte il budget
    if (VarToStr(selT275.Lookup('CODICE',Causale,'ABBATTE_BUDGET')) = 'L') and
       ((VarToStr(selT275.Lookup('CODICE',Causale,'NO_LIMITE_ANNUALE_LIQ')) = 'N') or (Parametri.CampiRiferimento.C2_Facoltativo <> 'L')) then
    begin
      A029FLiquidazione.GetOreLiquidate(SelAnagrafe.FieldByName('Progressivo').AsInteger,Data);
      if Liquidato > (R450DtM1.EccAutAnno['LIQUIDABILE'] + R450DtM1.EccAutAnno['CAUSALIZZATO'] + A029FLiquidazione.LiqT075Anno - A029FLiquidazione.LiqT071Anno - A029FLiquidazione.LiqT070 - A029FLiquidazione.LiqT074Anno - A029FLiquidazione.AssT071Anno) then
        Liquidato:=Max(0,R450DtM1.EccAutAnno['LIQUIDABILE'] + R450DtM1.EccAutAnno['CAUSALIZZATO'] + A029FLiquidazione.LiqT075Anno - A029FLiquidazione.LiqT071Anno - A029FLiquidazione.LiqT070 - A029FLiquidazione.LiqT074Anno - A029FLiquidazione.AssT071Anno);
    end;
    if ArrLiq > 1 then
      Liquidato:=(Liquidato div ArrLiq) * ArrLiq;
    Residuo:=Liquidabile - Liquidato + (Max(0,R450DtM1.RiepPres[k].CompensabileMeseEff - R450DtM1.RiepPres[k].CompensabileMese));
    if VarToStr(selT275.Lookup('CODICE',Causale,'ORENORMALI')) = 'A' then
      Compensabile:=Residuo
    else
      Compensabile:=0;
    if Compensabile > (MaxComp - R450DtM1.RiepPres[k].CompensabileMese) then
      Compensabile:=MaxComp - R450DtM1.RiepPres[k].CompensabileMese;
    if Compensabile < 0 then
      Compensabile:=0;
    if ArrComp > 1 then
      Compensabile:=(Compensabile div ArrComp) * ArrComp;
    Riporto:=Residuo - Compensabile;
  end;
  TabellaStampa.FieldByName('Liquidabile').Value:=R180MinutiOre(Liquidabile);
  TabellaStampa.FieldByName('Liquidato').Value:=R180MinutiOre(Liquidato);
  TabellaStampa.FieldByName('Liquidato_Disp').Value:=TabellaStampa.FieldByName('Liquidato').Value;
  TabellaStampa.FieldByName('Residuo').Value:=R180MinutiOre(Residuo);
  TabellaStampa.FieldByName('Compensabile').Value:=R180MinutiOre(Compensabile);
  TabellaStampa.FieldByName('Riporto').Value:=R180MinutiOre(Riporto);
  LRiepBloccato:=DatoBloccato(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Data);
  if LRiepBloccato then
    TabellaStampa.FieldByName('Anomalia').AsString:='X';
  if ((Liquidato + Compensabile) = 0) and (TabellaStampa.FieldByName('Anomalia').AsString = '') then
  begin
    TabellaStampa.Cancel;
    ImpostaCampiTabellaStampaReadonly(True);
    exit;
  end;

  //Registro la liquidazione solo se il riepilogo non è bloccato
  if (Aggiornamento) and ((Liquidato + Compensabile) > 0) then
  begin
    // in caso di riepilogo bloccato dà segnalazione
    if LRiepBloccato then
    begin
      RegistraMsg.InserisciMessaggio('B',Format(A000MSG_DATIBLOCCATI_ERR_FMT_DATI_NONMODIF,['Liquidazione di ' + Data.ToString('mmmm yyyy'),COD_RIEPILOGO]),Parametri.Azienda,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    end
    else
    begin
      // controlli sul budget
      if Parametri.CampiRiferimento.C2_Facoltativo = '' then
      begin
        Esegui:=True;
      end
      else
      begin
        // simula la liquidazione per calcolare l'importo da confrontare con il budget
        LiquidazionePresenza(True,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Data,Causale,Liquidato,Compensabile,TipoDisponibilita);
        ImpLiq:=A029FLiquidazione.A029FBudgetDtM1.CtrlLiqGetImporto(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger ,Data);

        // controllo sforamento budget
        Esegui:=A029FLiquidazione.A029FBudgetDtM1.ControllaBudget(False,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger ,Data,Liquidato,ImpLiq);
      end;

      // se è tutto ok effettua la liquidazione
      if Esegui then
      begin
        LiquidazionePresenza(False,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger ,Data,Causale,Liquidato,Compensabile,TipoDisponibilita);

        RegistraLog.SettaProprieta('M','T073_SCHEDACAUSPRES',NomeOwner,nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger ),'');
        RegistraLog.InserisciDato('DATA',DateToStr(Data),'');
        RegistraLog.InserisciDato('CAUSALE',Causale,'');
        RegistraLog.RegistraOperazione;
      end
      else
      begin
        // disponibilità non sufficiente: anomalia
        // - segnalare nella colonna "Anomalia" in stampa con flag = S
        // - annullare questa liquidazione ma proseguire con le succesive
        TabellaStampa.FieldByName('Anomalia').AsString:='S';
      end;
    end;
  end;

  // determina il nuovo id riga
  IdRiga:=IdRiga + 1;
  TabellaStampa.FieldByName('IdRiga').AsInteger:=IdRiga;
  TabellaStampa.Post;

  ImpostaCampiTabellaStampaReadonly(True);
end;

procedure TA091FLiquidPresenzeMW.LiquidazioneDatiModificati(Anno,Mese,TipoDisponibilita,IdRiga: Integer);
var
  Anomalia, Causale: String;
  Prog, Liquidato, Compensabile: Integer;
  Esegui: Boolean;
  ImpLiq: Real;
  Data: TDateTime;
begin
  if not TabellaStampa.Locate('IdRiga',IdRiga,[]) then
    raise Exception.Create('Liquidazione non disponibile');

  Prog:=TabellaStampa.FieldByName('Progressivo').AsInteger;
  Data:=EncodeDate(Anno,Mese,1);
  Anomalia:=TabellaStampa.FieldByName('Anomalia').AsString;
  Causale:=TabellaStampa.FieldByName('Causale').AsString;
  Liquidato:=R180OreMinuti(TabellaStampa.FieldByName('Liquidato').AsString);
  Compensabile:=R180OreMinuti(TabellaStampa.FieldByName('Compensabile').AsString);

  if Anomalia <> 'X' then
  begin
    // effettua i conteggi
    R450DtM1.ConteggiMese('Generico',Anno,Mese,Prog);

    // riepilogo non bloccato: procede con controlli se la liquidazione è significativa
    if ((Liquidato + Compensabile) > 0) then
    begin
      // controlli sul budget
      if Parametri.CampiRiferimento.C2_Facoltativo = '' then
      begin
        Esegui:=True;
      end
      else
      begin
        // simula la liquidazione per calcolare l'importo da confrontare con il budget
        LiquidazionePresenza(True,Prog,Data,Causale,Liquidato,Compensabile,TipoDisponibilita);
        ImpLiq:=A029FLiquidazione.A029FBudgetDtM1.CtrlLiqGetImporto(Prog,Data);

        // controllo sforamento budget
        Esegui:=A029FLiquidazione.A029FBudgetDtM1.ControllaBudget(False,Prog,Data,Liquidato,ImpLiq);
      end;

      // se è tutto ok effettua la liquidazione
      if Esegui then
      begin
        LiquidazionePresenza(False,Prog,Data,Causale,Liquidato,Compensabile,TipoDisponibilita);
        RegistraLog.SettaProprieta('M','T073_SCHEDACAUSPRES',NomeOwner,nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO',Prog.ToString,'');
        RegistraLog.InserisciDato('DATA',DateToStr(Data),'');
        RegistraLog.InserisciDato('CAUSALE',Causale,'');
        RegistraLog.RegistraOperazione;
        SessioneOracle.Commit;
      end
      else
      begin
        // disponibilità non sufficiente: anomalia
        // - segnalare nella colonna "Anomalia" in stampa con flag = S
        // - annullare questa liquidazione ma proseguire con le succesive
        TabellaStampa.Edit;
        TabellaStampa.FieldByName('Anomalia').AsString:='S';
        TabellaStampa.Post;
      end;
    end;
  end;
end;

//Calcolo il fruito e aggiorno il budget straordinario
procedure TA091FLiquidPresenzeMW.PreparaAggiornaFruitoBudget(Data: TDateTime);
begin
  //Calcolo il fruito e aggiorno il budget straordinario
  if Parametri.CampiRiferimento.C2_Facoltativo <> '' then
  begin
    A029FLiquidazione.A029FBudgetDtM1.PreparaAggiornaFruitoBudget(Data,'#LIQ#');
    SessioneOracle.Commit;
  end;
end;

// ### ANNULLAMENTO LIQUIDAZIONI ###

function TA091FLiquidPresenzeMW.GetDataUltimaLiquidazioneAnno(PDataRif: TDateTime;PCausale: String; PLiquidazioni, PCompensazioni:Boolean) :TDateTime;
var
  S: String;
  P: Integer;
begin
  PCausale:='''' + StringReplace(PCausale,',',''',''',[rfReplaceAll]) + '''';
  S:=SelAnagrafe.SubstitutedSQL;
  S:=Copy(S,Pos('FROM',S),Length(S));
  P:=Pos('ORDER BY',S);
  if P > 0 then
    S:=Copy(S,1,P - 1);
  S:=' AND T073.PROGRESSIVO IN (SELECT PROGRESSIVO ' + S + ')';
  if selT074.VariableIndex('C700DATADAL') >= 0 then
    selT074.DeleteVariable('C700DATADAL');
  selT074.SetVariable('FILTRO',S);
  selT074.SetVariable('DATALAVORO',R180FineMese(PDataRif));
  selT074.SetVariable('CAUSALE',PCausale);
  selT074.SetVariable('LIQUIDAZIONI',IfThen(PLiquidazioni,'S','N'));
  selT074.SetVariable('COMPENSAZIONI',IfThen(PCompensazioni,'S','N'));
  if SelAnagrafe.VariableIndex('C700DATADAL') >= 0 then
  begin
    selT074.DeclareVariable('C700DATADAL',otDate);
    selT074.SetVariable('C700DATADAL',R180InizioMese(PDataRif));
  end;
  selT074.Execute;
  Result:=selT074.FieldAsDate(0);
end;

procedure TA091FLiquidPresenzeMW.ImpostaVarAnnulla(PData: TDateTime; PElencoCausali:String; PLiquidazioni, PCompensazioni:Boolean);
begin
  PElencoCausali:='''' + StringReplace(PElencoCausali,',',''',''',[rfReplaceAll]) + '''';
  updT073_T074.SetVariable('LIQUIDAZIONI',IfThen(PLiquidazioni,'S','N'));
  updT073_T074.SetVariable('COMPENSAZIONI',IfThen(PCompensazioni,'S','N'));
  updT073_T074.SetVariable('DATA',PData);
  updT073_T074.SetVariable('CAUSALE',PElencoCausali);
end;

procedure TA091FLiquidPresenzeMW.AnnullaLiquidazione(PData: TDateTime; PElencoCausali: String);
begin
  if not DatoBloccato(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,PData) then
  begin
    updT073_T074.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    updT073_T074.Execute;

    // registrazione log operazione
    RegistraLog.SettaProprieta('C','T073_SCHEDACAUSPRES',NomeOwner,nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger),'');
    RegistraLog.InserisciDato('DATA',DateToStr(PData),'');
    RegistraLog.InserisciDato('CAUSALE',PElencoCausali,'');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  end;
end;

end.
