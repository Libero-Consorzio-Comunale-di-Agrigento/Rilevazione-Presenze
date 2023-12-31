unit R350UCalcoloBuoniDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, Oracle, Math, QueryStorico, Variants,
  A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali,
  R450, Rp502Pro, R500Lin, DatiBloccati, DBClient;

const R350ANOM1  = 'Regole Buoni Pasto non trovate per il dipendente';
      R350ANOM2  = 'Trovata missione con rimborso pasto';
      R350ANOM3  = 'Dipendente non in servizio alla data di eleborazione';
      R350ANOM4  = 'Anomalia sui conteggi giornalieri';
      R350ANOM5  = 'Fruita causale che inibisce la maturazione';
      R350ANOM6  = 'Trovato accesso mensa';
      R350ANOM7  = 'Pausa mensa non prevista dall''orario';
      R350ANOM8  = 'Non � consentito usare orari spezzati';
      R350ANOM9 =  'Giorno non lavorativo';
      R350ANOM10 = 'Intervallo mensa non rispettato';
      R350ANOM11 = 'Ore rese inferiori alle minime richieste';
      R350ANOM12 = 'Rientro pomeridiano non verificato';
      R350ANOM13 = 'Richiesto rientro pomeridiano supplementare';
      R350ANOM14 = 'Giorno non abilitato alla maturazione';
      R350ANOM15 = 'Debito gg inferiore a quanto richiesto (%s)';
      R350ANOM16 = 'Debito gg superiore a quanto richiesto (%s)';
      R350ANOM17 = 'Saldo totale insufficiente (%s)';
      R350ANOM18 = 'Turni richiesti non effettuati';
      R350ANOM19 = 'Saldo insufficiente (%s - richiesto: %s)';
      R350ANOM20 = 'Raggiunto il limite settimanale di buoni maturati (%d)';

type
  TRegola = record
    Codice:String;
    Inizio,Fine:TDateTime;
  end;

  TEntrUsc = record
    E,U:Integer;
  end;

  TRiepilogoBT = record
    Tipo:String;
    Acquisto,
    ResiduoPrec,
    ResiduoAtt,
    RecuperoPrec,
    RecuperoAtt:Integer;
  end;

  TBuoniDaRientriPomeridiani = record
    Obbl,Suppl,Debito:Integer;
  end;

  TCheckSaldoAnnuo = record
    Progressivo,Saldo:Integer;
    DataCorr: TDatetime;
  end;

  TR350FCalcoloBuoniDtM = class(TDataModule)
    Q670: TOracleDataSet;
    Q100: TOracleDataSet;
    Q680: TOracleDataSet;
    Q692: TOracleDataSet;
    selT040: TOracleDataSet;
    selGGLav: TOracleQuery;
    selResiduo: TOracleDataSet;
    selPeriodoAcquisto: TOracleDataSet;
    selMediaT680: TOracleDataSet;
    selPeriodoServizio: TOracleDataSet;
    Q690: TOracleQuery;
    selT375: TOracleDataSet;
    selRimborsiMissioni: TOracleDataSet;
    selRecuperoPrec: TOracleDataSet;
    selT690: TOracleDataSet;
    insT680: TOracleQuery;
    TabellaStampa: TClientDataSet;
    insT690: TOracleQuery;
    insT682: TOracleQuery;
    selT670RegolaCustom: TOracleQuery;
    selT682: TOracleDataSet;
    procedure R350FCalcoloBuoniDtMCreate(Sender: TObject);
    procedure R350FCalcoloBuoniDtMDestroy(Sender: TObject);
  private
    { Private declarations }
    DipendenteInServizio:TDipendenteInServizio;
    Regola:TRegola;
    RMProgressivo:Integer;
    SessioneOracleR350:TOracleSession;
    BuoniDaRientriPomeridiani:TBuoniDaRientriPomeridiani;
    OreMinime:Integer;
    CheckSaldoAnnuo:TCheckSaldoAnnuo;
    R400: TDataModule; //TR400FCartellinoDtM;
    R450DtM1: TR450DtM1;
    Elenco:TStringList;
    function CalcolaBuonoRegola(Prog:Integer; Data:TDateTime; var Buoni,Ticket:Integer; var Anom:String):String;
    function MaturaTicket(Prog:Integer; Data:TDateTime; S:String):Boolean;
    function IntervalloMensa(IMMin,IMMax:Integer):Boolean;
    function GetAcquistiTeorici(Prog:Integer; Dal,Al,Inizio,Fine,DataMaturazione:TDateTime):Integer;
    procedure RegistraMaturazione(Prog,Buoni,Ticket:LongInt; Data:TDateTime);
    function GetBuoniMensaMaturati(Prog:Integer; DaData,AData,DataI:TDateTime; var Buoni,Ticket:Integer):Boolean;
    procedure InizializzaRientriPomeridiani(Prog:Integer; Data:TDateTime);
    procedure InserisciDipendente(Prog,Buoni,Ticket:Integer; Data:TDateTime; Anom,Manuale:String; Stampa:Boolean);
    procedure InserisciAcquisto(Prog:Integer);
    procedure RegistraAcquisto(Prog:LongInt; Data:TDateTime);

  public
    { Public declarations }
    QSBuonoMensa:TQueryStorico;
    RiepilogoBT:TRiepilogoBT;
    R502ProDtM1:TR502ProDtM1;
    EsisteRegola:Boolean;
    RMStampa,RMIgnoraAnomalie,RMRegistrazione:Boolean;
    RMCampoRagg:String;
    selDatiBloccati:TDatiBloccati;
    selAnagrafe:TOracleDataSet;
    function GetMaturazioneGG(Prog:Integer; Data:TDateTime):Integer;
    function CalcolaBuoni(Prog:Integer; Data:TDateTime; var Buoni,Ticket:Integer; var Anom:String):String;
    function CalcolaAcquisto(Prog:Integer; DataAcquisto:TDateTime; SoloResidui:Boolean):Boolean;
    procedure GetVariazioni(Prog:Integer; A,M:Integer; var VB,VT:Integer);
    procedure RiepilogoMensileMaturazione(Progressivo:Integer; DaData,AData,DataI:TDateTime);
    procedure RiepilogoMensileAcquisto(Progressivo:Integer; Data:TDateTime);
  end;

//var
//  R350FCalcoloBuoniDtM: TR350FCalcoloBuoniDtM;

implementation

{$R *.DFM}

uses R400UCartellinoDtM;

procedure TR350FCalcoloBuoniDtM.R350FCalcoloBuoniDtMCreate(Sender: TObject);
var i:Integer;
begin
  SessioneOracleR350:=SessioneOracle;
  if Self.Owner <> nil then
    if Self.Owner is TOracleSession then
      SessioneOracleR350:=Self.Owner as TOracleSession;
  (*if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;*)
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracleR350;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracleR350;
  end;
  R450DtM1:=nil;
  Q670.Open;
  QSBuonoMensa:=TQueryStorico.Create(nil);
  QSBuonoMensa.Session:=SessioneOracleR350;
  DipendenteInServizio:=TDipendenteInServizio.Create(nil);
  DipendenteInServizio.Session:=SessioneOracleR350;
  R502ProDtM1:=TR502ProDtM1.Create(nil);
  selT375.SetVariable('PROGRESSIVO',0);
  selT375.SetVariable('DATA1',0);
  selT375.SetVariable('DATA2',0);
  selDatiBloccati:=TDatiBloccati.Create(Self);
  RMCampoRagg:='';
  RMStampa:=False;
  RMIgnoraAnomalie:=False;
  RMRegistrazione:=False;
  CheckSaldoAnnuo.Progressivo:=-1;
  CheckSaldoAnnuo.DataCorr:=0;
  CheckSaldoAnnuo.Saldo:=0;
  Elenco:=TStringList.Create;
end;

function TR350FCalcoloBuoniDtM.GetMaturazioneGG(Prog:Integer; Data:TDateTime):Integer;
var Buoni,Ticket:Integer;
    Anom:String;
begin
  CalcolaBuoni(Prog,Data,Buoni,Ticket,Anom);
  Result:=Buoni + Ticket;
end;

function TR350FCalcoloBuoniDtM.CalcolaBuoni(Prog:Integer; Data:TDateTime; var Buoni,Ticket:Integer; var Anom:String):String;
{Maturazione buoni/ticket in un dato giorno gestendo la ricorsivit� delle regole}
var Campo:String;
    lstRegole:TStringList;
begin
  lstRegole:=TStringList.Create;
  Buoni:=0;
  Ticket:=0;
  EsisteRegola:=False;

  try
    if QSBuonoMensa.LocDatoStorico(Data) then
      Campo:=QSBuonoMensa.FieldByName('T430' + Parametri.CampiRiferimento.C4_BuoniMensa).AsString
    else
      Campo:='';

    if not Q670.SearchRecord('CODICE',Campo,[srFromBeginning]) then
    begin
      Result:=R350ANOM1;
      exit;
    end;
    EsisteRegola:=True;
    while Buoni + Ticket = 0 do
    begin
      lstRegole.Add(Q670.FieldByName('CODICE').AsString);
      Result:=CalcolaBuonoRegola(Prog,Data,Buoni,Ticket,Anom);
      if Buoni + Ticket > 0 then
        Break
      else if Q670.FieldByName('REGOLA_SUCCESSIVA').IsNull then
        Break
      else if Q670.SearchRecord('CODICE',Q670.FieldByName('REGOLA_SUCCESSIVA').AsString,[srFromBeginning]) then
      begin
        if lstRegole.IndexOf(Q670.FieldByName('CODICE').AsString) >= 0 then
          Break;
      end
      else
        Break;
    end;

    //Alberto 01/03/2021: registrazione della maturazione giornaliera x BARI_PROVINCIA e MESSINA_NEUROLESI
    if (RMRegistrazione and (Q670.FieldByName('TURNILAV_GG').AsInteger > 0)) or
       (Q670.FieldByName('NUM_MAX_BUONI_SETTIMANA').AsInteger > 0) then
      with insT682 do
      begin
        SetVariable('PROGRESSIVO',Prog);
        SetVariable('DATA',Data);
        SetVariable('BUONIPASTO',Buoni);
        SetVariable('TICKET',Ticket);
        try
          Execute;
        except
        end;
      end;
  finally
    FreeAndNil(lstRegole);
    Q100.Close;
    selT375.Close;
    selRimborsiMissioni.Close;
  end;
end;

function TR350FCalcoloBuoniDtM.CalcolaBuonoRegola(Prog:Integer; Data:TDateTime; var Buoni,Ticket:Integer; var Anom:String):String;
{Maturazione buoni/ticket in un dato giorno secondo le regole}
var (*Campo,*)Da,A:String;
    OreLav,OreAssenza,OreEccedenza:Integer;
    i,MatPrec:Integer;
    SaldoAnnuoAllaData:Integer;
    Fasce,Rientro:Boolean;
    MP,GC:Boolean;{MP:MattinaPomeriggio,GC:GiornoCompleto}
  function EseguiConteggiGG:String;
  begin
    Result:='';
    Fasce:=False;
    R502ProDtM1.f03_com:='';
    (*Se sono specificate le fasce entro cui rendere le ore minime,
      si richiamano i conteggi con la formula DALLE*hhmm
      per annullare i conteggi dei turni notturni sull'entrata, in modo da poter conteggiare
      tutte le timbrature nell'arco delle 24 ore (anche gli smonti notte)*)
    if (not(Q670.FieldByName('Da1').IsNull) and not(Q670.FieldByName('A1').IsNull)) or
       (not(Q670.FieldByName('Da2').IsNull) and not(Q670.FieldByName('A2').IsNull)) then
    begin
      Fasce:=True;
      Da:=FormatDateTime('hhnn',Q670.FieldByName('Da1').AsDateTime);
      A:=FormatDateTime('hhnn',Q670.FieldByName('A1').AsDateTime);
      R502ProDtM1.f03_com:='DALLE*0000';
      R502ProDtM1.Conteggi('Cartolina',Prog,Data);
      //Dipendente non in servizio
      if R502ProDtM1.dipinser = 'no' then
      begin
        Result:=R350ANOM3;
        exit;
      end;
      if R502ProDtM1.Blocca <> 0 then
      begin
        Anom:='Anomalia';
        Result:=R350ANOM4;
        exit;
      end;
    end;
    //Conteggio tutto il giorno
    if not Fasce then
    begin
      R502ProDtM1.Conteggi('Cartolina',Prog,Data);
      if R502ProDtM1.dipinser = 'no' then
      begin
        Result:=R350ANOM3;
        exit;
      end;
      if R502ProDtM1.Blocca <> 0 then
      begin
        Anom:='Anomalia';
        Result:=R350ANOM4;
        exit;
      end;
    end;
  end;
  function MattinaPomeriggio:Boolean;
  var FMatt,IPom,i:Integer;
  begin
    Result:=False;
    with R502ProDtM1 do
    begin
      if ((R502ProDtM1.TipoOrario <> 'C') and (R502ProDtM1.PeriodoLavorativo = 'S')) then
      begin
        FMatt:=UscitaNominale[1]; //Ora di fine del mattino
        IPom:=EntrataNominale[2]; //Ora di inizio del pomeriggio
      end
      else if (Q670.FieldByName('FASCE_MATPOM_PMT').AsString = 'S') and (TipoDetPaumen = 'PMT') and (Length(TimbratureMensa) > 0) then
      begin
        FMatt:=TimbratureMensa[0].I;
        IPom:=TimbratureMensa[0].F;
      end
      else
      begin
        FMatt:=R180OreMinutiExt(Q670.FieldByName('INIZIO_POMERIGGIO').AsString);
        IPom:=R180OreMinutiExt(Q670.FieldByName('INIZIO_POMERIGGIO').AsString);
      end;
      if (FMatt = -1) or (IPom = -1) then exit;
      (*Controllo le ore minime del mattino:
        includo le timbrature e i giustificativi di assenza tollerati con entrata <= FineMattina*)
      OreLav:=0;
      for i:=1 to n_timbrcon do
        if (ttimbraturecon[i].tcaus <> '') and R180InConcat(ttimbraturecon[i].tcaus,Q670.FieldByName('PRESENZA').AsString) then
          Continue
        else if ttimbraturecon[i].tminutic_e <= FMatt then
          inc(OreLav,Min(ttimbraturecon[i].tminutic_u,FMatt) - ttimbraturecon[i].tminutic_e);
      for i:=1 to n_giusdaa do
        if tgius_dallealle[i].tassenza then
          if R180InConcat(tgius_dallealle[i].tcausdaa,Q670.FieldByName('ASSENZA').AsString) and
             (RiepAssenza[tgius_dallealle[i].tcausdaa,'HHRESE'] > 0) and
             (tgius_dallealle[i].tminutida <= FMatt) then
            inc(OreLav,Min(tgius_dallealle[i].tminutia,FMatt) - tgius_dallealle[i].tminutida);
      if OreLav < R180OreMinutiExt(Q670.FieldByName('ORE_MATTINA').AsString) then
        exit;
      (*Controllo le ore minime del pomeriggio:
        includo le timbrature e i giustificativi di assenza tollerati con uscita >= InizioPomeriggio*)
      OreLav:=0;
      for i:=1 to n_timbrcon do
        if (ttimbraturecon[i].tcaus <> '') and R180InConcat(ttimbraturecon[i].tcaus,Q670.FieldByName('PRESENZA').AsString) then
          Continue
        else if ttimbraturecon[i].tminutic_u >= IPom then
          inc(OreLav,ttimbraturecon[i].tminutic_u - Max(ttimbraturecon[i].tminutic_e,IPom));
      for i:=1 to n_giusdaa do
        if tgius_dallealle[i].tassenza then
          if R180InConcat(tgius_dallealle[i].tcausdaa,Q670.FieldByName('ASSENZA').AsString) and
             (RiepAssenza[tgius_dallealle[i].tcausdaa,'HHRESE'] > 0) and
             (tgius_dallealle[i].tminutia >= IPom) then
            inc(OreLav,tgius_dallealle[i].tminutia - Max(tgius_dallealle[i].tminutida,IPom));
      if OreLav < R180OreMinutiExt(Q670.FieldByName('ORE_POMERIGGIO').AsString) then
        exit;
    end;
    if Q670.FieldByName('PASTO_TICKET').AsString = 'T' then
      Ticket:=1
    else
      Buoni:=1;
    if (((Q670.FieldByName('PASTO_TICKET').AsString = 'T') and (Ticket = 1)) or
       ((Q670.FieldByName('PASTO_TICKET').AsString = 'B') and (Buoni = 1))) then
      Result:=True;
  end;
  function GiornataComplessiva:Boolean;
  var i,OrePres:Integer;
      L:TStringList;
      Ret:Boolean;
  begin
    Ret:=False;
    OreLav:=0;
    OreAssenza:=0;
    OreEccedenza:=0;
    //Conteggio ore lavorate = ore in fasce + ore escluse dalle normali
    for i:=1 to R502ProDtM1.n_fasce do
      inc(OreLav,R502ProDtM1.tminlav[i]);
    for i:=1 to R502ProDtM1.n_rieppres do
      if R502ProDtM1.ValStrT275[R502ProDtM1.triepgiuspres[i].tcauspres,'ORENORMALI'] = 'A' then
        inc(OreLav,R180SommaArray(R502ProDtM1.triepgiuspres[i].tminpres));
    //inc(OreLav,R502ProDtM1.minlavesc + R502ProDtM1.mintipoAesc);
    if Q670.FieldByName('OREMIN_NETTOPM').AsString = 'N' then //Alberto 09/02/2007: parametrizzabile per AIPO e Firenze_Comune
      inc(OreLav,R502ProDtM1.paumendet);
    //Elimino dalle ore lavorate le ore causalizzate specificate nelle regole
    L:=TStringList.Create;
    L.CommaText:=Q670.FieldByName('PRESENZA').AsString;
    for i:=1 to R502ProDtM1.n_rieppres do
      if Trim(R502ProDtM1.triepgiuspres[i].tcauspres) <> '' then
        if L.IndexOf(R502ProDtM1.triepgiuspres[i].tcauspres) >= 0 then
          dec(OreLav,R180SommaArray(R502ProDtM1.triepgiuspres[i].tminpres));
    //Elimino dalle ore lavorate le ore rese da assenza
    for i:=1 to R502ProDtM1.n_riepasse do
    begin
      dec(OreLav,R502ProDtM1.triepgiusasse[i].tminresasse);
      inc(OreAssenza,R502ProDtM1.triepgiusasse[i].tminresasse);
    end;
    OrePres:=OreLav;//Alberto 17/12/2012: salvo le ore di oresenza (escludendo quelle di assenza) per TORINO_COMUNE
    L.Clear;
    L.CommaText:=Q670.FieldByName('ASSENZA').AsString;
    for i:=1 to R502ProDtM1.n_riepasse do
      if L.IndexOf(R502ProDtM1.triepgiusasse[i].tcausasse) >= 0 then
      begin
        inc(OreLav,R502ProDtM1.triepgiusasse[i].tminresasse);
        dec(OreAssenza,R502ProDtM1.triepgiusasse[i].tminresasse);
      end;
    OreEccedenza:=R180SommaArray(R502ProDtM1.tminstrgio);
    OreMinime:=R180OreMinuti(Q670.FieldByName('OREMINIME').AsDateTime);
    if OreLav >= OreMinime then
    begin
      if Q670.FieldByName('PASTO_TICKET').AsString = 'T' then
        Ticket:=1
      else
        Buoni:=1;
      //Alberto 17/12/2012: maturazione x TORINO_COMUNE solo se le ore di presenza raggungono la met� del debito
      if (Pos('<MEZZO DEBITO>',Q670.FieldByName('FORZAMATURAZIONE').AsString) > 0) and (OrePres < (R502ProDtM1.debitogg div 2)) then
      begin
        Ticket:=0;
        Buoni:=0;
      end;
      if (((Q670.FieldByName('PASTO_TICKET').AsString = 'T') and (Ticket = 1)) or
         ((Q670.FieldByName('PASTO_TICKET').AsString = 'B') and (Buoni = 1))) then
        Ret:=True;
    end;
    L.Free;
    Result:=Ret;
  end;
  procedure FasceOrarie;
  var i,F1Da,F1A,F2Da,F2A,E,U,
      OreLavM,OreLavP,OrePres,app:Integer;
      L:TStringList;
  begin
    L:=TStringList.Create;
    L.CommaText:=Q670.FieldByName('PRESENZA').AsString;
    F1Da:=R180OreMinuti(Q670.FieldByName('Da1').AsDateTime);
    F1A:=R180OreMinuti(Q670.FieldByName('A1').AsDateTime);
    F2Da:=R180OreMinuti(Q670.FieldByName('Da2').AsDateTime);
    F2A:=R180OreMinuti(Q670.FieldByName('A2').AsDateTime);
    OreLav:=0;
    OreLavM:=0;
    OreLavP:=0;
    with R502ProDtM1 do
    begin
      (*Conteggio timbrature nelle fasce richieste
      escludendo quelle causalizzate con causali specificate nelle regole*)
      for i:=1 to n_timbrcon do
      begin
        if (ttimbraturecon[i].tcaus <> '') and (L.IndexOf(ttimbraturecon[i].tcaus) >= 0) then Continue;
        E:=Max(ttimbraturecon[i].tminutic_e,F1Da);
        U:=Min(ttimbraturecon[i].tminutic_u,F1A);
        if E < U then
          inc(OreLavM,U - E);
        if (Q670.FieldByName('FASCIA1_ESCLUSIVA').AsString = 'S') and (ttimbraturecon[i].tminutic_e < F1A) then
        begin
          E:=0;
          U:=0;
        end
        else
        begin
          E:=Max(ttimbraturecon[i].tminutic_e,F2Da);
          U:=Min(ttimbraturecon[i].tminutic_u,F2A);
        end;
        if E < U then
          inc(OreLavP,U - E);
        if Q670.FieldByName('OREMINIME_FASCE').AsString = 'E' then
        begin
          E:=Max(ttimbraturecon[i].tminutic_e,IfThen(Q670.FieldByName('Da1').IsNull,F2Da,F1Da));
          U:=Min(ttimbraturecon[i].tminutic_u,IfThen(Q670.FieldByName('A2').IsNull,F1A,F2A));
          if E < U then
            inc(OreLav,U - E);
        end;
      end;
      OrePres:=OreLavM + OreLavP;
      (*Inclusione assenze specificate*)
      L.Clear;
      L.CommaText:=Q670.FieldByName('ASSENZA').AsString;
      app:=0;
      for i:=1 to n_giusgga do
        if L.IndexOf(tgius_ggass[i].tcausggass) >= 0 then
          inc(app,tgius_ggass[i].mmresi);
      for i:=1 to n_giusmga do
        if L.IndexOf(tgius_mgass[i].tcausmgass) >= 0 then
          inc(app,tgius_mgass[i].mmresi);
      for i:=1 to n_giusore do
        if L.IndexOf(tgius_min[i].tcausore) >= 0 then
          inc(app,tgius_min[i].tmin);
      inc(OreLavM,app);
      if Q670.FieldByName('OREMINIME_FASCE').AsString = 'E' then
        inc(OreLav,app);
      for i:=1 to n_giusdaa do
        if L.IndexOf(tgius_dallealle[i].tcausdaa) >= 0 then
        begin
          E:=Max(tgius_dallealle[i].tminutida,F1Da);
          U:=Min(tgius_dallealle[i].tminutia,F1A);
          if E < U then
            inc(OreLavM,U - E);
          E:=Max(tgius_dallealle[i].tminutida,F2Da);
          U:=Min(tgius_dallealle[i].tminutia,F2A);
          if E < U then
            inc(OreLavP,U - E);
          if Q670.FieldByName('OREMINIME_FASCE').AsString = 'E' then
          begin
            E:=Max(tgius_dallealle[i].tminutida,IfThen(Q670.FieldByName('Da1').IsNull,F2Da,F1Da));
            U:=Min(tgius_dallealle[i].tminutia,IfThen(Q670.FieldByName('A2').IsNull,F1A,F2A));
            if E < U then
              inc(OreLav,U - E);
          end;
        end;
    end;
    L.Free;

    if Q670.FieldByName('OREMINIME_FASCE').AsString = 'N' then
      OreLav:=9999
    else if Q670.FieldByName('OREMINIME_FASCE').AsString = 'S' then
      OreLav:=OreLavM + OreLavP;
    if Q670.FieldByName('OREMIN_NETTOPM').AsString = 'S' then //Alberto 05/07/2007: parametrizzabile per AIPO e Firenze_Comune
    begin
      dec(OreLav,R502ProDtM1.paumendet);
      dec(OrePres,R502ProDtM1.paumendet);
    end;
    dec(OreLav,R502ProDtM1.DetrazStraord);
    dec(OrePres,R502ProDtM1.DetrazStraord);
    OreMinime:=R180OreMinuti(Q670.FieldByName('OREMINIME').AsDateTime);
    if (OreLav >= OreMinime) and
       (OreLavM >= R180OreMinutiExt(Q670.FieldByName('ORE_MATTINA').AsString)) and
       (OreLavP >= R180OreMinutiExt(Q670.FieldByName('ORE_POMERIGGIO').AsString)) then
      if Q670.FieldByName('PASTO_TICKET').AsString = 'T' then
        Ticket:=1
      else
        Buoni:=1;
    //Alberto 17/12/2012: maturazione x TORINO_COMUNE solo se le ore di presenza raggungono la met� del debito
    if (Pos('<MEZZO DEBITO>',Q670.FieldByName('FORZAMATURAZIONE').AsString) > 0) and (OrePres < (R502ProDtM1.debitogg div 2)) then
    begin
      Ticket:=0;
      Buoni:=0;
    end;
  end;
  function MinimoTurniLavorati(NumGG,NumOre:Integer):Boolean;
  var D:TDateTime;
      i,j,NumOreLav:Integer;
      S:String;
      EsisteTurnoNotturno,SequenzaTurni:Boolean;
  begin
    //Verifico che siano state lavorate NumOre nei NumGG gg precedenti, con un turno notturno nel periodo
    Result:=False;
    NumOreLav:=0;
    EsisteTurnoNotturno:=False;
    SequenzaTurni:=True;
    R502ProDtM1.f03_com:='';
    D:=Data - NumGG + 1;
    while D <= Data + 1 do
    try
      R502ProDtM1.Conteggi('Cartolina',Prog,D);
      if (R502ProDtM1.Blocca > 0) or (R502ProDtM1.ggvuoto = 1) or (R502ProDtM1.ggvuoto_turnista = 1) then
      begin
        SequenzaTurni:=False;
      end
      else
      begin
        EsisteTurnoNotturno:=False;
        //Verifico se � stato lavorato un turno notturno
        if (not EsisteTurnoNotturno) and (R502ProDtM1.TipoOrario = 'E') and (R502ProDtM1.PeriodoLavorativo = 'T1') then
        begin
          for i:=1 to R502ProDtM1.n_timbrnom do
          begin
            if (R502ProDtM1.ttimbraturenom[i].tpuntre = 0) or
               (R502ProDtM1.ttimbraturenom[i].tpuntru = 0) or
               (R502ProDtM1.ttimbraturenom[i].tminutin_e = 0) or
               (R502ProDtM1.ttimbraturenom[i].tminutin_u >= 1440)
            then
            begin
              for j:=1 to R502ProDtM1.n_timbrdip do
                if R502ProDtM1.ttimbraturedip[j].tpuntnomin = i then
                begin
                  EsisteTurnoNotturno:=True;
                  Break;
                end
                else if (R502ProDtM1.ttimbraturedip[j].tpuntnomin = 0) and
                        (R502ProDtM1.ttimbraturedip[j].tminutid_e = 0) and
                        ((R502ProDtM1.ttimbraturedip[j].tcausale_e.tcaus = '') or
                         (not R180InConcat(R502ProDtM1.ttimbraturedip[j].tcausale_e.tcaus, Q670.FieldByName('PRESENZA').AsString)))
                then
                begin
                  EsisteTurnoNotturno:=True;
                  Break;
                end
            end;
            if EsisteTurnoNotturno then
              Break;
          end;
        end;
        (*
        if EsisteTurnoNotturno and (D < Data) then
        begin
          SequenzaTurni:=False;
          Continue;
        end;
        if (not EsisteTurnoNotturno) and (D = Data) then
        begin
          SequenzaTurni:=False;
          Continue;
        end;
        *)

        //Non considero smonto notte sul primo gg
        if (D = Data - NumGG + 1) and (EsisteTurnoNotturno) and (R502ProDtM1.primat_u = 'si') then
        begin
          Continue;
        end;
        //Considero ultimo gg solo se smonto notte
        if (D > Data) then
        begin
          if not EsisteTurnoNotturno then
            Continue
          else if R502ProDtM1.ultimt_e = 'si' then
          begin
            //Se Turno notturno ma c'� un altra entrata in notte verifico la causale se � esclusa dai conteggi posso considerare il turno valido
            if ((R502ProDtM1.TimbratureDelGiorno[High(R502ProDtM1.TimbratureDelGiorno)].tcaustimb = '') or
                (not R180InConcat(R502ProDtM1.TimbratureDelGiorno[High(R502ProDtM1.TimbratureDelGiorno)].tcaustimb, Q670.FieldByName('PRESENZA').AsString))) then
            Continue;
          end;
        end;

        //Calcolo ore rese
        inc(NumOreLav,R180SommaArray(R502ProDtM1.tminlav));
        for i:=1 to R502ProDtM1.n_rieppres do
          if R502ProDtM1.ValStrT275[R502ProDtM1.triepgiuspres[i].tcauspres,'ORENORMALI'] = 'A' then
            inc(NumOreLav,R180SommaArray(R502ProDtM1.triepgiuspres[i].tminpres));
        if Q670.FieldByName('OREMIN_NETTOPM').AsString = 'N' then //Alberto 09/02/2007: parametrizzabile per AIPO e Firenze_Comune
          inc(NumOreLav,R502ProDtM1.paumendet);
        //Elimino dalle ore lavorate le ore causalizzate specificate nelle regole
        for i:=1 to R502ProDtM1.n_rieppres do
          if Trim(R502ProDtM1.triepgiuspres[i].tcauspres) <> '' then
            if R180In(R502ProDtM1.triepgiuspres[i].tcauspres,Q670.FieldByName('PRESENZA').AsString.Split([','])) then
              dec(NumOreLav,R180SommaArray(R502ProDtM1.triepgiuspres[i].tminpres));
        //Elimino dalle ore lavorate le ore rese da assenza
        for i:=1 to R502ProDtM1.n_riepasse do
          dec(NumOreLav,R502ProDtM1.triepgiusasse[i].tminresasse);
        for i:=1 to R502ProDtM1.n_riepasse do
          if R180In(R502ProDtM1.triepgiusasse[i].tcausasse,Q670.FieldByName('ASSENZA').AsString.Split([','])) then
            inc(NumOreLav,R502ProDtM1.triepgiusasse[i].tminresasse);
      end;
      //?Verifica smonto notte su D = Data?
    finally
      D:=D + 1;
    end;

    Result:=SequenzaTurni and (NumOreLav >= NumOre);
  end;

  function GetSaldoAnnuoAllaData:Integer;
  begin
    Result:=0;
    if (R400 = nil) then
    begin
      R400:=TR400FCartellinoDtM.Create(nil);
      (R400 as TR400FCartellinoDtM).A027SelAnagrafe:=nil;
      (R400 as TR400FCartellinoDtM).SoloAggiornamento:=False;
     end;
    (R400 as TR400FCartellinoDtM).NumGiorniCartolina:=0;
    try
      //Eseguo la cartolina fino alla Data di conteggio
      (R400 as TR400FCartellinoDtM).CartolinaDipendente(Prog,R180Anno(Data),R180Mese(Data),1,R180Giorno(Data));
      //Considero il saldo complessivo al lordo della liquidazione di straordinario che se presente riguarda tutto il mese.
      Result:=(R400 as TR400FCartellinoDtM).R450DtM1.salannoatt + (R400 as TR400FCartellinoDtM).R450DtM1.totliqmm;
    except
    end;
  end;

  procedure TrovaVariabili;
  var
    Stringa,S:String;
    i,x:Integer;
  begin
    FreeAndNil(Elenco);
    Stringa:=Q670.FieldByName('REGOLA_CUSTOM').AsString;
    Elenco:=FindVariables(Stringa, False);
  end;

  procedure ElaboraVariabili(Prog:Integer; Data:TDateTime);
  var i:integer;
      ConteggiGG:Boolean;
  begin
    selT670RegolaCustom.DeleteVariables;
    if Elenco.Count > 0 then
    begin
      ConteggiGG:=False;
      for i:=0 to Elenco.Count - 1 do
      begin
        if Elenco[i].ToUpper = 'PROGRESSIVO' then
        begin
          selT670RegolaCustom.DeclareVariable(Elenco[i],otInteger);
          selT670RegolaCustom.SetVariable(Elenco[i],Prog);
        end
        else if Elenco[i].ToUpper = 'DATA' then
        begin
          selT670RegolaCustom.DeclareVariable(Elenco[i],otDate);
          selT670RegolaCustom.SetVariable(Elenco[i],Data);
        end
        else if R180In(Elenco[i].ToUpper,['ORARIO_GG','DEBITO_GG','ORE_GG','ASSENZE_GG','ECCEDENZA_GG','TIPO_PM','DETRAZ_PM','STACCO_PM']) then
        begin
          if not ConteggiGG then
          begin
            EseguiConteggiGG;
            GiornataComplessiva;
            Buoni:=0;
            Ticket:=0;
            ConteggiGG:=True;
          end;
          selT670RegolaCustom.DeclareVariable(Elenco[i],IfThen(R180In(Elenco[i].ToUpper,['ORARIO_GG','TIPO_PM']),otString,otInteger));
          if Elenco[i].ToUpper = 'ORARIO_GG' then
            selT670RegolaCustom.SetVariable(Elenco[i],R502ProDtM1.c_orario)
          else if Elenco[i].ToUpper = 'ORE_GG' then
            selT670RegolaCustom.SetVariable(Elenco[i],OreLav)
          else if Elenco[i].ToUpper = 'DEBITO_GG' then
            selT670RegolaCustom.SetVariable(Elenco[i],R502ProDtM1.debitogg)
          else if Elenco[i].ToUpper = 'ASSENZE_GG' then
            selT670RegolaCustom.SetVariable(Elenco[i],OreAssenza)
          else if Elenco[i].ToUpper = 'ECCEDENZA_GG' then
            selT670RegolaCustom.SetVariable(Elenco[i],OreEccedenza)
          else if Elenco[i].ToUpper = 'TIPO_PM' then
            selT670RegolaCustom.SetVariable(Elenco[i],R502ProDtM1.TipoDetPaumen)
          else if Elenco[i].ToUpper = 'DETRAZ_PM' then
            selT670RegolaCustom.SetVariable(Elenco[i],R502ProDtM1.paumendet)
          else if Elenco[i].ToUpper = 'STACCO_PM' then
            selT670RegolaCustom.SetVariable(Elenco[i],R502ProDtM1.StaccoPausaMensa)
          ;
        end
        else
        begin
          selT670RegolaCustom.DeclareVariable(Elenco[i],otString);
          selT670RegolaCustom.SetVariable(Elenco[i],null);
        end;
      end;
    end;
  end;

begin
  try
    Anom:='';
    Buoni:=0;
    Ticket:=0;
    OreLav:=0;
    OreAssenza:=0;
    OreEccedenza:=0;
    Result:='';
    // verifico esistenza di Regola personalizzata REGOLA_CUSTOM
    if (Q670.FindField('REGOLA_CUSTOM') <> nil) and
       (not Q670.FieldByName('REGOLA_CUSTOM').AsString.IsEmpty) then
    begin
      // cerco le variabili dichiarate nello script
      selT670RegolaCustom.Close;
      selT670RegolaCustom.SQL.Clear;
      selT670RegolaCustom.SQL.Text:='select ' + Q670.FieldByName('REGOLA_CUSTOM').AsString + ' from dual';
      TrovaVariabili;
      ElaboraVariabili(Prog,Data);
      // esegue richiamo alla funzione oracle
      try
        selT670RegolaCustom.Execute;
        // la regola eseguita correttamente e matura il Buono/Ticket
        if selT670RegolaCustom.FieldAsString(0) = 'S' then
        begin
          if Q670.FieldByName('PASTO_TICKET').AsString = 'T' then
            Ticket:=1
          else
            Buoni:=1;
          exit;
        end;
      except
        on E:Exception do
        begin
          RegistraMsg.InserisciMessaggio('A',Format('REGOLA_CUSTOM eseguita con errori: %s',[E.Message]),'',Prog);
        end;
      end;
    end;

    //Messina_Neurolesi: verifica saldo annuo positivo ogni X mesi
    if (Q670.FindField('RECUPERO_DEBITO_MM') <> nil) and
       (Q670.FieldByName('RECUPERO_DEBITO_MM').AsInteger >= 1) and
       (R180Mese(Data) mod Q670.FieldByName('RECUPERO_DEBITO_MM').AsInteger = 0) and
       (Data >= Q670.FieldByName('RECUPERO_DEBITO_START').AsDateTime)
    then
    begin
      if R450DtM1 = nil then
        R450DtM1:=TR450DtM1.Create(nil);
      //Se il saldo totale � negativo, non si matura il buono
      if (CheckSaldoAnnuo.Progressivo <> Prog) or
         (CheckSaldoAnnuo.DataCorr <> R180InizioMese(Data)) then
      begin
        CheckSaldoAnnuo.Progressivo:=Prog;
        CheckSaldoAnnuo.DataCorr:=R180InizioMese(Data);
        CheckSaldoAnnuo.Saldo:=0;
        //Lettura saldo al mese corrente (DataCorr)
        R450DtM1.ConteggiMese('Generico',R180Anno(CheckSaldoAnnuo.DataCorr),R180Mese(CheckSaldoAnnuo.DataCorr),Prog);
        CheckSaldoAnnuo.Saldo:=R450DtM1.SalAnnoAtt;
        //Se il saldo � negativo, verifico se l'ho reuperato il mese successivo (DataRecupero)
        if CheckSaldoAnnuo.Saldo < 0 then
        begin
          Result:=Format(R350ANOM17,[R180MinutiOre(CheckSaldoAnnuo.Saldo)]);
        end;
      end;

      //Non riconosco la maturazione ed esco subito, ma Result viene segnalato solo la prima volta per evitare il proliferare di log ridondanti
      if CheckSaldoAnnuo.Saldo < 0 then
      begin
        if Data = R180InizioMese(Data) then
          Result:=Format(R350ANOM17,[R180MinutiOre(CheckSaldoAnnuo.Saldo)]);
        exit;
      end;
    end;

    //Messina_Neurolesi: 3 turni in 2 gg
    if (Q670.FindField('TURNILAV_GG') <> nil) and
       (Q670.FieldByName('TURNILAV_GG').AsInteger > 0) and
       (R180OreMinuti(Q670.FieldByName('TURNILAV_ORE').AsString) > 0)
    then
    begin
      if not MinimoTurniLavorati(Q670.FieldByName('TURNILAV_GG').AsInteger,R180OreMinuti(Q670.FieldByName('TURNILAV_ORE').AsString)) then
      begin
        Result:=R350ANOM18;
        exit;
      end;
    end;

    //PALERMO_FOSS: indicazione esplicita dei giorni che possono maturare - Inizio
    if (Q670.FindField('TIPO_GIORNI_FISSI') <> nil) and (Q670.FieldByName('TIPO_GIORNI_FISSI').AsString = 'A') and (Q670.FieldByName('GIORNI_FISSI').AsString <> '') then
    begin
      Result:=R350ANOM14;
      for i:=1 to Length(Q670.FieldByName('GIORNI_FISSI').AsString) do
        if DayOfWeek(Data - 1) = StrToIntDef(Q670.FieldByName('GIORNI_FISSI').AsString[i],0) then
        begin
          Result:='';
          Break;
        end;
      if Result <> '' then
        exit;
    end;
    //PALERMO_FOSS - Fine
    //Lettura delle eventuali missioni aventi il rimborso pasto
    if (Q670.FieldByName('MISSIONI').AsString = 'S') and (Parametri.CampiRiferimento.C8_Missione <> '') then
      with selRimborsiMissioni do
      begin
        R180SetVariable(selRimborsiMissioni,'PROGRESSIVO',Prog);
        R180SetVariable(selRimborsiMissioni,'DATA',Data);
        try
          Open;
          if FieldByName('NUM').AsInteger > 0 then
          begin
            Result:=R350ANOM2;
            exit;
          end;
        except
        end;
      end;
    // gc 17/01/2020 --
    Result:=EseguiConteggiGG;
    if not Result.IsEmpty then
    begin
      if Result=R350ANOM4 then
        Anom:='Anomalia';
      exit;
    end;
    // ----------------
    R180SetVariable(Q100,'PROGRESSIVO',Prog);
    R180SetVariable(Q100,'DATA',Data);
    Q100.Open;
    //Maturazione forzata in presenza di particolari causali
    if MaturaTicket(Prog,Data,Q670.FieldByName('FORZAMATURAZIONE').AsString) then
    begin
      if Q670.FieldByName('PASTO_TICKET').AsString = 'T' then
        Ticket:=1
      else
        Buoni:=1;
      if MaturaTicket(Prog,Data,Q670.FieldByName('CAUS_TICKET').AsString) then
        if Ticket = 1 then
        begin
          Ticket:=0;
          Buoni:=1;
        end
        else
        begin
          Ticket:=1;
          Buoni:=0
        end;
      exit;
    end;
    if Q670.FieldByName('ACCESSI_MENSA').AsString = 'S' then
    begin
      R180SetVariable(selT375,'PROGRESSIVO',Prog);
      R180SetVariable(selT375,'DATA1',R180InizioMese(Data));
      R180SetVariable(selT375,'DATA2',R180FineMese(Data));
      selT375.Open;
    end;
    //Annullamento maturazione in presenza di particolari causali
    if MaturaTicket(Prog,Data,Q670.FieldByName('INIBMATURAZIONE').AsString) then
    begin
      Result:=R350ANOM5;
      exit;
    end;
    //Se c'� un accesso mensa si verifica l'abilitazione
    if (Q670.FieldByName('ACCESSI_MENSA').AsString = 'S') and
       ((R502ProDtM1.Q370.SearchRecord('DATA',Data,[srFromBeginning])) or
        (selT375.SearchRecord('DATA',Data,[srFromBeginning]))) then
    begin
      Result:=R350ANOM6;
      exit;
    end;
    //Se la pausa mensa non � gestita e l'orario non � spezzato si verifica l'abilitazione
    if (Q670.FieldByName('PAUSA_MENSA').AsString = 'S') and (R502ProDtM1.PausaMensa = 'Z') and (R502ProDtM1.PeriodoLavorativo <> 'S') then
    begin
      Result:=R350ANOM7;
      exit;
    end;
    if (Q670.FieldByName('PAUSA_MENSA_GESTITA').AsString = 'S') and (R502ProDtM1.paumenges <> 'si') and (R502ProDtM1.PeriodoLavorativo <> 'S') then
    begin
      Result:=R350ANOM7;
      exit;
    end;
    //Se l'orario � spezzato si verifica l'abilitazione
    if (R502ProDtM1.PeriodoLavorativo = 'S') and (Q670.FieldByName('ORARISPEZZATI').AsString <> 'S') then
    begin
      Result:=R350ANOM8;
      exit;
    end;
    //Controllo se giorno non lavorativo matura ugualmente
    if (Q670.FieldByName('NONLAVORATIVO').AsString = 'N') and (R502ProDtM1.gglav = 'no') then
    begin
      Result:=R350ANOM9;
      exit;
    end;
    if not IntervalloMensa(R180OreminutiExt(Q670.FieldByName('INTERVALLOMIN').AsString),R180OreminutiExt(Q670.FieldByName('INTERVALLOMAX').AsString)) then
    begin
      Result:=R350ANOM10;
      exit;
    end;
    //Se c'� un accesso mensa si verifica l'abilitazione
    if (Q670.FieldByName('ACCESSI_MENSA').AsString = 'S') and
       ((R502ProDtM1.Q370.SearchRecord('DATA',Data,[srFromBeginning])) or
        (selT375.SearchRecord('DATA',Data,[srFromBeginning]))) then
    begin
      Result:=R350ANOM6;
      exit;
    end;

    //Controllo se il debito giornaliero rispetta i limiti indicati
    if (Q670.FindField('DEBITO_MIN') <> nil) and (Q670.FindField('DEBITO_MAX') <> nil) then
    begin
      if (not Q670.FieldByName('DEBITO_MIN').IsNull) and (R180OreMinutiExt(Q670.FieldByName('DEBITO_MIN').AsString) > 0) and (R502ProDtM1.debitogg < R180OreMinutiExt(Q670.FieldByName('DEBITO_MIN').AsString)) then
      begin
        Result:=Format(R350ANOM15,[Q670.FieldByName('DEBITO_MIN').AsString]);
        exit;
      end;
      if (not Q670.FieldByName('DEBITO_MAX').IsNull) and (R180OreMinutiExt(Q670.FieldByName('DEBITO_MAX').AsString) > 0) and (R502ProDtM1.debitogg > R180OreMinutiExt(Q670.FieldByName('DEBITO_MAX').AsString)) then
      begin
        Result:=Format(R350ANOM16,[Q670.FieldByName('DEBITO_MAX').AsString]);
        exit;
      end;
    end;

    {Se sono specificati i Giorni_Fissi o il debito giornaliero minimo:
     se il giorno corrisponde alle richieste lo identifico per non fare i
     controlli successivi sulle ore minime.
     Controllo giorni_fissi: R502ProDtM1.giorsett
     Controllo debito_giornaliero: R502ProDtM1.debitogg
     se uno dei precedenti controlli � valido (=giorno di rientro), verificare
       Controllo che TimbratureDelGiorno[1].tversotimb <> ''
    }
    Rientro:=False;
    if (Q670.FindField('TIPO_GIORNI_FISSI') = nil) or (Q670.FieldByName('TIPO_GIORNI_FISSI').AsString = 'F') then
    begin
      if R180OreMinutiExt(Q670.FieldByName('DEBITO_GIORN_MIN').AsString) > 0 then
        Rientro:=R502ProDtM1.debitogg >= R180OreMinutiExt(Q670.FieldByName('DEBITO_GIORN_MIN').AsString)
      else if Q670.FieldByName('GIORNI_FISSI').AsString <> '' then
        for i:=1 to Length(Q670.FieldByName('GIORNI_FISSI').AsString) do
          if R502ProDtM1.giorsett = StrToIntDef(Q670.FieldByName('GIORNI_FISSI').AsString[i],0) then
          begin
            Rientro:=True;
            Break;
          end;
      if Rientro then
        //if R502ProDtM1.TimbratureDelGiorno[0].tversotimb <> '' then
        if Length(R502ProDtM1.TimbratureDelGiorno) > 0 then
          if Q670.FieldByName('PASTO_TICKET').AsString = 'T' then
            Ticket:=1
          else
            Buoni:=1;
    end;
    //Non fare se giorno di rientro
    {Controllo sull'eccedenza giornaliera minima
     totlav - debitogg}
    if (not Rientro) and
       (R180OreMinutiExt(Q670.FieldByName('ECCEDENZA_MIN').AsString) > 0) then
      if (R502ProDtM1.totlav - R502ProDtM1.debitogg) >=
         R180OreMinutiExt(Q670.FieldByName('ECCEDENZA_MIN').AsString) then
      begin
        if Q670.FieldByName('PASTO_TICKET').AsString = 'T' then
          Ticket:=1
        else
          Buoni:=1;
        Rientro:=True;  //Si annullano i controlli successivi sulle fasce: vince l'eccedenza giornaliera
      end;
    //Non fare se giorno di rientro
    if not Rientro then
    begin
      //Conteggio delle ore in base alle regole di maturazione
      if Fasce then
      begin
        if (Q670.FieldByName('OREMINIME_FASCE').AsString = 'S') or GiornataComplessiva then
        begin
          Buoni:=0;
          Ticket:=0;
          FasceOrarie;
        end;
      end
      else
      begin
        MP:=True;
        GC:=True;
        if Q670.FieldByName('PASTO_TICKET').AsString = 'T' then
          MatPrec:=Ticket
        else
          MatPrec:=Buoni;
        if ((R180OreMinutiExt(Q670.FieldByName('ORE_MATTINA').AsString) > 0) or
            (R180OreMinutiExt(Q670.FieldByName('ORE_POMERIGGIO').AsString) > 0)) and
           ((not Q670.FieldByName('INIZIO_POMERIGGIO').IsNull) or
            (Q670.FieldByName('FASCE_MATPOM_PMT').AsString = 'S') or
            (R502ProDtM1.TipoOrario <> 'C') and (R502ProDtM1.PeriodoLavorativo = 'S')) then
          MP:=MattinaPomeriggio;
        if R180OreMinuti(Q670.FieldByName('OREMINIME').AsDateTime) > 0 then
          GC:=GiornataComplessiva;
        if (Not(MP) or Not(GC)) and (MatPrec = 0) then
          if Q670.FieldByName('PASTO_TICKET').AsString = 'T' then
            Ticket:=0
          else
            Buoni:=0;
      end;
    end;
    if (Ticket = 0) and (Buoni = 0) then
      Result:=R350ANOM11;
    //Gestione dello scambio Buoni<-->Ticket in presenza di particolari causali
    if ((Buoni = 1) or (Ticket = 1)) and (Trim(Q670.FieldByName('CAUS_TICKET').AsString) <> '') then
      if MaturaTicket(Prog,Data,Q670.FieldByName('CAUS_TICKET').AsString) then
        if Buoni = 1 then
        begin
          Buoni:=0;
          Ticket:=1;
        end
        else if Ticket = 1 then
        begin
          Buoni:=1;
          Ticket:=0;
        end;

    //Controllo se viene richiesto il rientro pomeridiano
    if (Buoni + Ticket > 0) and (Q670.FieldByName('REGOLA_RIENTRO_POMERIDIANO').AsString = 'S') then
    begin
      if R502ProDtM1.RientroPomeridiano.BuonoPastoObbl + R502ProDtM1.RientroPomeridiano.BuonoPastoSuppl = 0 then
      begin
        Buoni:=0;
        Ticket:=0;
        Result:=R350ANOM12;
        exit;
      end
      else if (R502ProDtM1.RientroPomeridiano.BuonoPastoObbl = 1) and (BuoniDaRientriPomeridiani.Debito = BuoniDaRientriPomeridiani.Obbl) then
      begin
        Buoni:=0;
        Ticket:=0;
        Result:=R350ANOM13;
        exit;
      end
      else
      begin
        inc(BuoniDaRientriPomeridiani.Obbl,R502ProDtM1.RientroPomeridiano.BuonoPastoObbl);
        inc(BuoniDaRientriPomeridiani.Suppl,R502ProDtM1.RientroPomeridiano.BuonoPastoSuppl);
      end;
    end;
  finally
    //Bari_Provincia: limite settimanale
    if (Buoni + Ticket > 0) and
       (Q670.FindField('NUM_MAX_BUONI_SETTIMANA') <> nil) and
       (Q670.FieldByName('NUM_MAX_BUONI_SETTIMANA').AsInteger > 0)
    then
    begin
      R180SetVariable(selT682, 'PROGRESSIVO', Prog);
      R180SetVariable(selT682, 'DATA', Data);
      selT682.Open;
      //Controllo: query su T682 dal luned� della settimana corrente a Data - 1
      if (selT682.FieldByName('BUONIPASTO').AsInteger + Buoni > Q670.FieldByName('NUM_MAX_BUONI_SETTIMANA').AsInteger)
      or (selT682.FieldByName('TICKET').AsInteger + Ticket > Q670.FieldByName('NUM_MAX_BUONI_SETTIMANA').AsInteger) then
      begin
        Buoni:=0;
        Ticket:=0;
        Result:=Format(R350ANOM20,[Q670.FieldByName('NUM_MAX_BUONI_SETTIMANA').AsInteger]);
      end;
    end;

    //Palermo_Universita: saldo annuo fino a Data >= 01.00
    if (Buoni + Ticket > 0) and
       (Q670.FindField('SALDO_ANNUO_MINIMO') <> nil) and
       (not Q670.FieldByName('SALDO_ANNUO_MINIMO').IsNull)
    then
    begin
      SaldoAnnuoAllaData:=GetSaldoAnnuoAllaData;
      if SaldoAnnuoAllaData < R180OreMinuti(Q670.FieldByName('SALDO_ANNUO_MINIMO').AsString) then
      begin
        Buoni:=0;
        Ticket:=0;
        Result:=Format(R350ANOM19,[R180MinutiOre(SaldoAnnuoAllaData), Q670.FieldByName('SALDO_ANNUO_MINIMO').AsString]);
      end;
    end;
  end;
end;

function TR350FCalcoloBuoniDtM.MaturaTicket(Prog:Integer; Data:TDateTime; S:String):Boolean;
var L:TStringList;
    i,j:Integer;
begin
  Result:=False;
  L:=TStringList.Create;
  L.CommaText:=S;
  for i:=0 to L.Count - 1 do
  begin
    for j:=1 to R502ProDtM1.n_riepasse do
      if L[i] = R502ProDtM1.triepgiusasse[j].tcausasse then
      begin
        Result:=True;
        Break;
      end;
    if Result then
      Break;
    for j:=1 to R502ProDtM1.n_rieppres do
      if L[i] = R502ProDtM1.triepgiuspres[j].tcauspres then
      begin
        Result:=True;
        Break;
      end;
    if Result then
      Break;
  end;
  if not Result then
  begin
    for i:=0 to L.Count - 1 do
      if Q100.Locate('CAUSALE',L[i],[]) then
      begin
        Result:=True;
        Break;
      end;
  end;
  L.Free;
end;

function TR350FCalcoloBuoniDtM.IntervalloMensa(IMMin,IMMax:Integer):Boolean;
{Vengono considerate le timbrature intersecanti il periodo di mensa
 per verificare che l'intervallo di mensa sia compreso tra IMMin e IMMax}
var i,j,xx,Intervallo,IM,FM:Integer;
    Esiste,GiustifOK,AddGiust,AddTimb:Boolean;
    EntrUsc:array of TEntrUsc;
  procedure QuickSortTimbrCon(iLo,iHi:Integer);
  var Mid,Lo,Hi:Integer;
      T:t_TTimbratureCon;
  begin
    with R502ProDtM1 do
    begin
      Lo:=iLo;
      Hi:=iHi;
      Mid:=ttimbraturecon[(Lo + Hi) div 2].tminutic_e;
      repeat
        while ttimbraturecon[Lo].tminutic_e < Mid do Inc(Lo);
        while ttimbraturecon[Hi].tminutic_e > Mid do Dec(Hi);
        if Lo <= Hi then
        begin
          T:=ttimbraturecon[Lo];
          ttimbraturecon[Lo]:=ttimbraturecon[Hi];
          ttimbraturecon[Hi]:=T;
          Inc(Lo);
          Dec(Hi);
        end;
      until Lo > Hi;
    end;
    if Hi > iLo then QuickSortTimbrCon(iLo,Hi);
    if Lo < iHi then QuickSortTimbrCon(Lo,iHi);
  end;
  procedure QuickSortRiepGiusDalleAlle(iLo,iHi:Integer);
  var Mid,Lo,Hi:Integer;
      T:t_tgius_dallealle;
  begin
    with R502ProDtM1 do
    begin
      Lo:=iLo;
      Hi:=iHi;
      Mid:=tgius_dallealle[(Lo + Hi) div 2].tminutida;
      repeat
        while tgius_dallealle[Lo].tminutida < Mid do Inc(Lo);
        while tgius_dallealle[Hi].tminutida > Mid do Dec(Hi);
        if Lo <= Hi then
        begin
          T:=tgius_dallealle[Lo];
          tgius_dallealle[Lo]:=tgius_dallealle[Hi];
          tgius_dallealle[Hi]:=T;
          Inc(Lo);
          Dec(Hi);
        end;
      until Lo > Hi;
    end;
    if Hi > iLo then QuickSortRiepGiusDalleAlle(iLo,Hi);
    if Lo < iHi then QuickSortRiepGiusDalleAlle(Lo,iHi);
  end;
  function GetTimbraturaOriginale(Verso:Char; U,E:Integer):Integer;
  var i:Integer;
      EsisteTO:Boolean;
  begin
    Result:=IfThen(Verso = 'E',E,U);
    EsisteTO:=False;
    with R502ProDtM1 do
    begin
      for i:=0 to High(TimbratureDelGiorno) do
        if (TimbratureDelGiorno[i].tversotimb = Verso) and R180Between(TimbratureDelGiorno[i].toratimb,U,E) then
        begin
          EsisteTO:=True;
          Result:=TimbratureDelGiorno[i].toratimb;
          if Verso = 'E' then
            Break;
        end
        else if (Verso = 'U') and (TimbratureDelGiorno[i].tversotimb = 'E') and (TimbratureDelGiorno[i].toratimb = E) then
        begin
          Break;
        end;

      //Alberto 13/09/2018 - ReggioEmilia_Comune: (orario spezzato ma solo 2 timbrature la matt e il pom) caso particolare in cui le timbrature dei conteggi sono comprese nelle timbrature originali:
      //si annulla l'intervallo
      if not EsisteTo (*and (TipoOrario = 'A') and (PeriodoLavorativo = 'S')*) then
      begin
        for i:=0 to High(TimbratureOriginali) do
          if (TimbratureOriginali[i].e <= U) and (TimbratureOriginali[i].u >= E) then
          begin
            Result:=IfThen(Verso = 'E',U,E);
            Break;
          end;
      end;
    end;

  end;
  // daniloc.ini 21.06.2010
  // verifica se il giustificativo � completamente incluso in una delle timbrature conteggiate
  // serve per la corretta verifica dell'intervallo di mensa
  function InclusoInTimbraturaCon(Ent,Usc: Integer): Boolean;
  { Restituisce True se la coppia Ent..Usc � completamente inclusa in una delle timbrature conteggiate }
  var
    i: Byte; // n_timbrcon � di tipo byte...
  begin
    Result:=False;
    for i:=1 to R502ProDtM1.n_timbrcon do
      if (Ent >= R502ProDtM1.ttimbraturecon[i].tminutic_e) and
         (Usc <= R502ProDtM1.ttimbraturecon[i].tminutic_u) then
      begin
        Result:=True;
        Break;
      end;
  end;
  // daniloc.fine
begin
  Result:=False;
  IM:=R502ProDtM1.InizioMensa;
  FM:=R502ProDtM1.FineMensa;
  //Alberto 13/09/2018 - ReggioEmilia_Comune: se orario spezzato si amplia la fascia di mensa col ritardo del pomeriggio (se in flessibilit�).
  if (R502ProDtM1.TipoOrario = 'A') and (R502ProDtM1.PeriodoLavorativo = 'S') then
    inc(FM,R502ProDtM1.ttimbraturenom[2].Flex);

  SetLength(EntrUsc,0);
  xx:=-1;
  j:=0;
  i:=0;
  (*
  if (R502ProDtM1.TipoDetPaumen = 'PMT') and (Length(R502ProDtM1.TimbratureMensa) > 0) then
  begin
    SetLength(EntrUsc,2);
    EntrUsc[0].U:=R502ProDtM1.TimbratureMensa[0].I;
    EntrUsc[1].E:=R502ProDtM1.TimbratureMensa[0].F;
  end
  else
  *)
  begin
    //Merge tra timbrature e giustificativi dalle-alle
    with R502ProDtM1 do
    begin
      if n_timbrcon > 0 then
        QuickSortTimbrCon(1,n_timbrcon);
      if n_giusdaa > 0 then
        QuickSortRiepGiusDalleAlle(1,n_giusdaa);
      while (i + j) < (n_timbrcon + n_giusdaa) do
      begin
        AddGiust:=False;
        AddTimb:=False;
        if (i >= n_timbrcon) and (j < n_giusdaa) then
          AddGiust:=True
        else if (j >= n_giusdaa) and (i < n_timbrcon) then
          AddTimb:=True
        else if ttimbraturecon[i + 1].tminutic_e <= tgius_dallealle[j + 1].tminutida then
          AddTimb:=True
        else if tgius_dallealle[j + 1].tminutida < ttimbraturecon[i + 1].tminutic_e then
          AddGiust:=True;
        if AddGiust then
        begin
          inc(j);
          if tgius_dallealle[j].tassenza then
            GiustifOK:=Pos(',' + tgius_dallealle[j].tcausdaa + ',',',' + Q670.FieldByName('ASSENZA').AsString + ',' + Q670.FieldByName('ASSENZA_PM').AsString + ',') > 0
          else
            GiustifOK:=Pos(',' + tgius_dallealle[j].tcausdaa + ',',',' + Q670.FieldByName('PRESENZA').AsString + ',') = 0;
          if GiustifOK then
          begin
            // daniloc.ini 21.06.2010
            // verifica che tminutida..tminutia non sia compreso in nessuna coppia di timbraturecon
            if not InclusoInTimbraturaCon(tgius_dallealle[j].tminutida,tgius_dallealle[j].tminutia) then
            // daniloc.fine
            begin
              inc(xx);
              SetLength(EntrUsc,xx + 1);
              EntrUsc[xx].E:=tgius_dallealle[j].tminutida;
              EntrUsc[xx].U:=tgius_dallealle[j].tminutia;
            end;
          end;
        end;
        if AddTimb then
        begin
          inc(i);
          inc(xx);
          SetLength(EntrUsc,xx + 1);
          // utilizza la timbratura in ingresso reale
          (*if (IntervalloUscita.OraOriginale <> -1) and
             (IntervalloUscita.OraNuova <> -1) and
             (IntervalloUscita.OraNuova = ttimbraturecon[i].tminutic_e) then
            EntrUsc[xx].E:=IntervalloUscita.OraOriginale
          else*)
          EntrUsc[xx].E:=ttimbraturecon[i].tminutic_e;
          EntrUsc[xx].U:=ttimbraturecon[i].tminutic_u;
        end;
      end;
    end;
  end;

  //Alberto 24/01/2019 - ReggioEmilia_Comune:
  //Se PMT gestita ed esiste nelle coppie EntrUsc, considero rigidamente solo quella. In caso contrario viene fatto il controllo su tutte le coppie.
  if (R502ProDtM1.TipoDetPaumen = 'PMT') and (Length(R502ProDtM1.TimbratureMensa) > 0) then
  begin
    Esiste:=False;
    for i:=0 to High(EntrUsc) - 1 do
    begin
      if (EntrUsc[i].U = R502ProDtM1.TimbratureMensa[0].I) and
         (EntrUsc[i + 1].E = R502ProDtM1.TimbratureMensa[0].F) then
      begin
        SetLength(EntrUsc,2);
        EntrUsc[0].E:=0;
        EntrUsc[0].U:=R502ProDtM1.TimbratureMensa[0].I;
        EntrUsc[1].E:=R502ProDtM1.TimbratureMensa[0].F;
        EntrUsc[1].U:=1440;
        Esiste:=True;
        Break;
      end;
    end;
    if not Esiste then
    begin
      for i:=1 to R502ProDtM1.n_timbrdip - 1 do
      begin
        if (R502ProDtM1.ttimbraturedip[i].tminutid_u = R502ProDtM1.TimbratureMensa[0].I) and
           (R502ProDtM1.ttimbraturedip[i + 1].tminutid_e = R502ProDtM1.TimbratureMensa[0].F) then
        begin
          SetLength(EntrUsc,2);
          EntrUsc[0].E:=0;
          EntrUsc[0].U:=R502ProDtM1.TimbratureMensa[0].I;
          EntrUsc[1].E:=R502ProDtM1.TimbratureMensa[0].F;
          EntrUsc[1].U:=1440;
          Esiste:=True;
          Break;
        end;
      end;
    end;
  end;

  //Controllo dello stacco di mensa
  Esiste:=False;
  for i:=0 to High(EntrUsc) - 1 do
  begin
    if Q670.FieldByName('INTERVALLO_EFFETTIVO').AsString = 'S' then
    begin
      EntrUsc[i].U:=GetTimbraturaOriginale('U',EntrUsc[i].U,EntrUsc[i + 1].E);
      EntrUsc[i + 1].E:=GetTimbraturaOriginale('E',EntrUsc[i].U,EntrUsc[i + 1].E);
    end;

    if (EntrUsc[i].U <= FM) and
       (EntrUsc[i + 1].E >= IM) then
    begin
      Esiste:=True;
      if (Q670.FindField('INTERVALLO_INTERNO_PMT') <> nil) and (Q670.FieldByName('INTERVALLO_INTERNO_PMT').AsString = 'S') then
        //Considero solo la parte dello stacco EntrUsc intersecante la fascia IM-FM
        Intervallo:=Max(0,Min(FM,EntrUsc[i + 1].E) - Max(IM,EntrUsc[i].U))
      else
        //Considero tutto l'intervallo identificato dallo stacco EntrUsc
        Intervallo:=Max(0,EntrUsc[i + 1].E - EntrUsc[i].U);
      if (Intervallo >= IMMin) and (Intervallo <= IMMax) then
      begin
        //Alberto 31/01/2014 - Perugia_Regione: se il rientro dalla pm � dopo le 15 non si matura il buono
        if (Intervallo = 0) or (Q670.FieldByName('RIENTRO_MASSIMO_PM').IsNull) or (EntrUsc[i + 1].E <= R180OreMinutiExt(Q670.FieldByName('RIENTRO_MASSIMO_PM').AsString)) then
        begin
          Result:=True;
          Break;
        end;
      end;
    end;
  end;

  //Se non ci sono timbrature che ricadono nell'intervallo di mensa e IMMin = 0, si matura il buono
  if (not Esiste) and (IMMin = 0) then
    Result:=True;
end;

function TR350FCalcoloBuoniDtM.CalcolaAcquisto(Prog:Integer; DataAcquisto:TDateTime; SoloResidui:Boolean):Boolean;
{Calcolo buoni da acquistare (Varese, ARPA, IUAV}
var GGBase,ConguaglioMax,ConguaglioPrecMax,RestituzioneMax:Integer;
    AcquistoMinimo,Diff:Integer;
    DataInizioAcquisto,DataFineAcquisto,DataMaturazione,DataResiduoPrecedente:TDateTime;
    //Campo:String;
    AcquistoTeorico:String;
    AcquistoAbilitato:Boolean;
  procedure GetPeriodoAcquisto;
  var i:Integer;
      S:String;
  begin
    DataInizioAcquisto:=Max(R180InizioMese(DataAcquisto),Regola.Inizio);
    DataFineAcquisto:=Min(R180FineMese(DataAcquisto),Regola.Fine);
    S:=Q670.FieldByName('PERIODICITA_ACQUISTO').AsString;
    if (*(Pos('S',S) = 0) or *)(Pos('N',S) = 0) then exit;
    if Pos('S',S) = 0 then
    begin
      DataInizioAcquisto:=0;
      DataFineAcquisto:=0;
      exit;
    end;
    i:=R180Mese(DataAcquisto);
    if (R180CarattereDef(S,i,'N') = 'N') and (DataInizioAcquisto = R180InizioMese(DataAcquisto)) then
      repeat
        DataInizioAcquisto:=R180AddMesi(DataInizioAcquisto,-1);
        dec(i);
        if i = 0 then
          i:=12;
      until R180CarattereDef(S,i,'N') = 'S';
    i:=R180Mese(DataAcquisto);
    if DataFineAcquisto = R180FineMese(DataAcquisto) then
      repeat
        inc(i);
        if i = 13 then
          i:=1;
        if R180CarattereDef(S,i,'N') = 'N' then
          DataFineAcquisto:=R180AddMesi(DataFineAcquisto,1);
      until R180CarattereDef(S,i,'N') = 'S';
    DataFineAcquisto:=R180FineMese(DataFineAcquisto);
  end;
  function AcquistoDalAl:Integer;
  begin
    Result:=0;
    if not Q670.SearchRecord('CODICE',Regola.Codice,[srFromBeginning]) then
      exit;
    AcquistoTeorico:=Q670.FieldByName('ACQUISTO_TEORICO').AsString;
    if (AcquistoTeorico = 'B') and (GGBase > 0) then
      exit;
    ConguaglioMax:=Abs(Q670.FieldByName('CONGUAGLIO_MAX').AsInteger);
    ConguaglioPrecMax:=0;
    RestituzioneMax:=Abs(Q670.FieldByName('RESTITUZIONE_MAX').AsInteger);
    AcquistoMinimo:=Abs(Q670.FieldByName('ACQUISTO_MINIMO').AsInteger);
    //Calcolo del periodo interessato all'acquisto
    GetPeriodoAcquisto;
    //Leggo il periodo di servizio corrente in base al flag rapporti_uniti di T030; INIZIO viene letto al primo del mese
    with selPeriodoServizio do
    begin
      Close;
      SetVariable('PROGRESSIVO',Prog);
      //SetVariable('DATAINIZIO',DataInizioAcquisto);
      SetVariable('DATAFINE',DataFineAcquisto);
      Open;
      if DataInizioAcquisto < FieldByName('INIZIO').AsDateTime then
        DataInizioAcquisto:=FieldByName('INIZIO').AsDateTime;
      if DataFineAcquisto > FieldByName('FINE').AsDateTime then
        DataFineAcquisto:=FieldByName('FINE').AsDateTime;
    end;
    //Verifica che non siano presenti altri acquisti nel periodo interessato,
    //tranne che per la data di riferimento che pu� essere ricalcolata
    with selPeriodoAcquisto do
    begin
      Close;
      SetVariable('PROGRESSIVO',Prog);
      SetVariable('DATA1',R180InizioMese(DataInizioAcquisto));
      SetVariable('DATA2',R180FineMese(DataFineAcquisto));
      SetVariable('DATARIF',R180InizioMese(DataAcquisto));
      Open;
      if (FieldByName('BUONI').AsInteger > 0) or (FieldByName('TICKET').AsInteger > 0) then
      begin
        Close;
        exit;
      end;
    end;
    AcquistoAbilitato:=True;
    //Lettura giorni lavorativi del mese
    DataMaturazione:=R180AddMesi(R180InizioMese(DataInizioAcquisto), -Q670.FieldByName('MESE_ASSENZE').AsInteger);
    //Alberto 22/09/2009: la data di maturazione non pu� essere inferiore alla data di assunzione
    //problema di REGIONE_PIEMONTE quando il dip. ha gestione dei rapporti unificati = 'N'. In questo caso non si devono considerare le precedenti maturazioni.
    //if DataMaturazione < selPeriodoServizio.FieldByName('INIZIO').AsDateTime then
    //  DataMaturazione:=selPeriodoServizio.FieldByName('INIZIO').AsDateTime;
    if selPeriodoServizio.FieldByName('FINE').IsNull or (selPeriodoServizio.FieldByName('FINE').AsDateTime >= DataMaturazione) then
      Result:=GetAcquistiTeorici(Prog,DataInizioAcquisto,DataFineAcquisto,selPeriodoServizio.FieldByName('INIZIO').AsDateTime,selPeriodoServizio.FieldByName('FINE').AsDateTime,DataMaturazione);
  end;
begin
  RiepilogoBT.Tipo:='';
  RiepilogoBT.Acquisto:=0;
  RiepilogoBT.RecuperoAtt:=0;
  RiepilogoBT.RecuperoPrec:=0;
  RiepilogoBT.ResiduoAtt:=0;
  RiepilogoBT.ResiduoPrec:=0;
  GGBase:=0;
  AcquistoAbilitato:=False;
  AcquistoTeorico:='';
  DataAcquisto:=R180FineMese(DataAcquisto);
  //Lettura delle regole di riferimento
  QSBuonoMensa.GetDatiStorici('T430' + Parametri.CampiRiferimento.C4_BuoniMensa,Prog,R180InizioMese(DataAcquisto),DataAcquisto);
  Regola.Codice:='';
  Regola.Inizio:=R180InizioMese(DataAcquisto) - 1;
  Regola.Fine:=R180InizioMese(DataAcquisto) - 1;
  QSBuonoMensa.First;
  while not QSBuonoMensa.Eof do
  begin
    if Regola.Codice <> QSBuonoMensa.FieldByName('T430' + Parametri.CampiRiferimento.C4_BuoniMensa).AsString then
    begin
      if Regola.Codice <> '' then
        GGBase:=GGBase + AcquistoDalAl;
      //In caso di calcolo come media dei mesi precedenti, si esegue solo una volta anche se ci sono pi� periodi diversi
      if (AcquistoTeorico = 'B') and (GGBase > 0) then
        Break;
      Regola.Codice:=QSBuonoMensa.FieldByName('T430' + Parametri.CampiRiferimento.C4_BuoniMensa).AsString;
      Regola.Inizio:=QSBuonoMensa.FieldByName('T430DATADECORRENZA').AsDateTime;
    end;
    Regola.Fine:=QSBuonoMensa.FieldByName('T430DATAFINE').AsDateTime;
    QSBuonoMensa.Next;
  end;
  //In caso di calcolo come media dei mesi precedenti, si esegue solo una volta anche se ci sono pi� periodi diversi
  if (AcquistoTeorico <> 'B') or (GGBase = 0) then
    GGBase:=GGBase + AcquistoDalAl;
  Result:=AcquistoAbilitato;
  if not Result then
    exit;
  //Arpa: gestione del residuo ad una data fissata
  RiepilogoBT.ResiduoPrec:=0;
  if not Q670.FieldByName('RESIDUO_PRECEDENTE').IsNull then
  begin
    //Lettura del residuo alla data RESIDUO_PRECEDENTE
    DataResiduoPrecedente:=Q670.FieldByName('RESIDUO_PRECEDENTE').AsDateTime;
    ConguaglioPrecMax:=Abs(Q670.FieldByName('CONGUAGLIO_PREC_MAX').AsInteger);
    with selResiduo do
    begin
      Close;
      SetVariable('PROGRESSIVO',Prog);
      SetVariable('ANNO',R180Anno(DataResiduoPrecedente));
      SetVariable('ACQUISTO1',EncodeDate(R180Anno(DataResiduoPrecedente),1,1));
      SetVariable('ACQUISTO2',R180InizioMese(DataResiduoPrecedente));
      SetVariable('RECUPERO1',R180AddMesi(R180InizioMese(DataResiduoPrecedente),1));
      SetVariable('RECUPERO2',R180AddMesi(R180InizioMese(DataResiduoPrecedente),Q670.FieldByName('MESE_ASSENZE').AsInteger));
      SetVariable('INIZIO',selPeriodoServizio.FieldByName('INIZIO').AsDateTime);
      SetVariable('FINE',selPeriodoServizio.FieldByName('FINE').AsDateTime);
      SetVariable('MESE_ASSENZE',Q670.FieldByName('MESE_ASSENZE').AsInteger);
      Open;
      if Q670.FieldByName('PASTO_TICKET').AsString = 'B' then
        RiepilogoBT.ResiduoPrec:=FieldByName('BUONI').AsInteger
      else
        RiepilogoBT.ResiduoPrec:=FieldByName('TICKET').AsInteger;
    end;
    //Lettura dei recuperi fatti esplicitamente sul Residuo Precedente
    with selRecuperoPrec do
    begin
      Close;
      SetVariable('PROGRESSIVO',Prog);
      SetVariable('RECUPERO_PREC1',R180AddMesi(R180InizioMese(DataResiduoPrecedente),Q670.FieldByName('MESE_ASSENZE').AsInteger + 1));
      SetVariable('RECUPERO_PREC2',R180AddMesi(R180InizioMese(DataInizioAcquisto),-1));
      SetVariable('INIZIO',selPeriodoServizio.FieldByName('INIZIO').AsDateTime);
      SetVariable('FINE',selPeriodoServizio.FieldByName('FINE').AsDateTime);
      Open;
      if Q670.FieldByName('PASTO_TICKET').AsString = 'B' then
        RiepilogoBT.ResiduoPrec:=RiepilogoBT.ResiduoPrec - FieldByName('BUONI').AsInteger
      else
        RiepilogoBT.ResiduoPrec:=RiepilogoBT.ResiduoPrec - FieldByName('TICKET').AsInteger;
    end;
  end;
  //Fine Arpa
  //Calcolo recupero complessivo da applicare all'interno del periodo di servizio corrente
  with selResiduo do
  begin
    Close;
    SetVariable('PROGRESSIVO',Prog);
    SetVariable('ANNO',R180Anno(DataMaturazione));
    SetVariable('ACQUISTO1',EncodeDate(R180Anno(DataMaturazione),1,1));
    SetVariable('ACQUISTO2',R180InizioMese(DataMaturazione));
    SetVariable('RECUPERO1',R180AddMesi(R180InizioMese(DataMaturazione),1));
    SetVariable('RECUPERO2',R180AddMesi(R180InizioMese(DataInizioAcquisto),-1));
    SetVariable('INIZIO',selPeriodoServizio.FieldByName('INIZIO').AsDateTime);
    SetVariable('FINE',selPeriodoServizio.FieldByName('FINE').AsDateTime);
    SetVariable('MESE_ASSENZE',Q670.FieldByName('MESE_ASSENZE').AsInteger);
    Open;
    if Q670.FieldByName('PASTO_TICKET').AsString = 'B' then
      RiepilogoBT.ResiduoAtt:=FieldByName('BUONI').AsInteger
    else
      RiepilogoBT.ResiduoAtt:=FieldByName('TICKET').AsInteger;
    Close;
    if SoloResidui then
      exit;
    //Il residuo precedente � significativo solo se positivo. Non pu� superare Residuo
    RiepilogoBT.ResiduoPrec:=Min(Max(0,RiepilogoBT.ResiduoPrec),Max(0,RiepilogoBT.ResiduoAtt));
    RiepilogoBT.ResiduoAtt:=RiepilogoBT.ResiduoAtt - RiepilogoBT.ResiduoPrec;
    //La quantit� da recuperare/restituire non pu� superare il Conguaglio o la Restituzione Max
    RiepilogoBT.RecuperoPrec:=0;
    if RiepilogoBT.ResiduoAtt > 0 then
    begin
      RiepilogoBT.RecuperoAtt:=Min(ConguaglioMax,RiepilogoBT.ResiduoAtt);
      RiepilogoBT.RecuperoPrec:=Min(ConguaglioPrecMax,RiepilogoBT.ResiduoPrec);
    end
    else
      //In negativo perch� restituzione
      RiepilogoBT.RecuperoAtt:=-Min(RestituzioneMax,Abs(RiepilogoBT.ResiduoAtt));
    {Il recupero non pu� superare la differenza GGBase - AcquistoMinimo,
     altrimenti si ha un acquisto minore di AcquistoMinimo -> (Min(Recupero,GGBase - AcquistoMinimo)).
     Se GGBase � minore di AcquistoMinimo, la differenza � negativa: si recupera 0 -> Max(0,...)}
    Diff:=(RiepilogoBT.RecuperoAtt + RiepilogoBT.RecuperoPrec) - Max(0,GGBase - AcquistoMinimo);
    if Diff > 0 then
    begin
      Dec(RiepilogoBT.RecuperoAtt,Min(RiepilogoBT.RecuperoAtt,Diff));
      Diff:=Max(0,RiepilogoBT.RecuperoPrec - Max(0,GGBase - AcquistoMinimo));
      Dec(RiepilogoBT.RecuperoPrec,Min(RiepilogoBT.RecuperoPrec,Diff));
    end;
    RiepilogoBT.Acquisto:=GGBase - (RiepilogoBT.RecuperoAtt + RiepilogoBT.RecuperoPrec);
    RiepilogoBT.Tipo:=Q670.FieldByName('PASTO_TICKET').AsString;
  end;
end;

function TR350FCalcoloBuoniDtM.GetAcquistiTeorici(Prog:Integer; Dal,Al,Inizio,Fine,DataMaturazione:TDateTime):Integer;
var Media:Boolean;
    DataInizioMaturazione:TDateTime;
    i,MesiAcq,MediaAcq:Integer;
    Causali:String;
begin
  Result:=0;
  Media:=False;
  if Q670.FieldByName('ACQUISTO_TEORICO').AsString = 'C' then
  begin
    Result:=Q670.FieldByName('ACQUISTO_QUANTITA').AsInteger;
    Exit;
  end;
  //Calcolo dei buoni da acquistare in base alla media di quelli maturati precedentemente
  if Q670.FieldByName('ACQUISTO_TEORICO').AsString = 'B' then
  begin
    DataInizioMaturazione:=R180InizioMese(R180AddMesi(DataMaturazione,-Q670.FieldByName('MEDIAMAX_ACQUISTO').AsInteger + 1));
    with selMediaT680 do
    begin
      Close;
      SetVariable('PROGRESSIVO',Prog);
      SetVariable('DATA1',DataInizioMaturazione);
      SetVariable('DATA2',DataMaturazione);
      SetVariable('INIZIO',Inizio);
      SetVariable('FINE',Fine);
      Open;
      //Verifico che esistano i mesi nella quantit� richiesta, altrimenti si conteggiano i giorni da calendario
      if FieldByName('MESI').AsInteger >= Q670.FieldByName('MEDIAMIN_ACQUISTO').AsInteger then
      begin
        Media:=True;
        if Q670.FieldByName('PASTO_TICKET').AsString = 'B' then
          MediaAcq:=FieldByName('BUONI').AsInteger div FieldByName('MESI').AsInteger
        else
          MediaAcq:=FieldByName('TICKET').AsInteger div FieldByName('MESI').AsInteger;
        MesiAcq:=0;
        while R180AddMesi(Dal,MesiAcq) < Al do
        begin
          if DipendenteInServizio.DipendenteInServizio(Prog,R180InizioMese(R180AddMesi(Dal,MesiAcq)),R180FineMese(R180AddMesi(Dal,MesiAcq))) then
            inc(Result,MediaAcq);
          inc(MesiAcq);
        end;
      end;
      Close;
    end;
  end;
  if Media then exit;
  {Giorni da calendario:
   Sono i giorni di calendario lavorativi in cui il dipendente � in servizio
   A seconda dei parametri:
     - si escludono le assenze a giornata non comprese nell'elenco
     - si eslcudono i giorni il cui modello orario prevede un debito inferiore alle ore minime
     - si escludono i giorni il cui modello orario non prevede la pausa mensa}
  with selGGLav do
  begin
    SetVariable('PROGRESSIVO',Prog);
    //SetVariable('DADATA',R180InizioMese(Dal));
    //SetVariable('ADATA',R180FineMese(Al));
    SetVariable('DADATA',Dal);
    SetVariable('ADATA',Al);
    SetVariable('SEMPRE_CALENDARIO','S');
    if (Q670.FindField('GGLAV_SEMPRE_CALENDARIO') <> nil) and (not Q670.FieldByName('GGLAV_SEMPRE_CALENDARIO').IsNull) then
      SetVariable('SEMPRE_CALENDARIO',Q670.FieldByName('GGLAV_SEMPRE_CALENDARIO').AsString);
    SetVariable('NOPIANIF_CALENDARIO','N');
    if (Q670.FindField('GGLAV_NOPIANIF_CALENDARIO') <> nil) and (not Q670.FieldByName('GGLAV_NOPIANIF_CALENDARIO').IsNull) then
      SetVariable('NOPIANIF_CALENDARIO',Q670.FieldByName('GGLAV_NOPIANIF_CALENDARIO').AsString);
    SetVariable('TIPOMENSA','*');
    SetVariable('PERLAV',Q670.FieldByName('ORARISPEZZATI').AsString); //Lorena 10/09/2004
    if Q670.FieldByName('HHMIN_ACQUISTO').AsString = 'S' then
    begin
      if Q670.FieldByName('PAUSA_MENSA').AsString = 'S' then
        SetVariable('TIPOMENSA','Z');
      if ((R180OreMinutiExt(Q670.FieldByName('ORE_MATTINA').AsString) = 0) and
         (R180OreMinutiExt(Q670.FieldByName('ORE_POMERIGGIO').AsString) = 0)) then
        SetVariable('MINIMO',R180OreMinuti(Q670.FieldByName('OREMINIME').AsDatetime))
      else
        SetVariable('MINIMO',R180OreMinutiExt(Q670.FieldByName('ORE_MATTINA').AsString) + R180OreMinutiExt(Q670.FieldByName('ORE_POMERIGGIO').AsString));
    end
    else
      SetVariable('MINIMO',0);
    Causali:='';
    if Q670.FieldByName('ASSENZE_ACQUISTO').AsString = 'S' then
    begin
      with TStringList.Create do
      try
       CommaText:=Q670.FieldByName('ASSENZA').AsString;
       for i:=0 to Count - 1 do
       begin
         if Causali <> '' then Causali:=Causali + ',';
         Causali:=Causali + '''' + Strings[i] + '''';
       end;
      finally
        Free;
      end;
      if Causali = '' then
        Causali:=''' ''';
    end
    else
      Causali:='''''';
    SetVariable('CAUSALI',Causali);
    Execute;
    Result:=FieldAsInteger(0);
  end;
end;

procedure TR350FCalcoloBuoniDtM.GetVariazioni(Prog:Integer; A,M:Integer; var VB,VT:Integer);
begin
  VB:=0;
  VT:=0;
  Q680.Close;
  Q680.SetVariable('PROGRESSIVO',Prog);
  Q680.SetVariable('ANNO',A);
  Q680.SetVariable('MESE',M);
  Q680.Open;
  if Q680.RecordCount > 0 then
  begin
    VB:=Q680.FieldByName('VARBUONIPASTO').AsInteger;
    VT:=Q680.FieldByName('VARTICKET').AsInteger;
  end;
  Q680.Close;
end;

procedure TR350FCalcoloBuoniDtM.RiepilogoMensileMaturazione(Progressivo:Integer; DaData,AData,DataI:TDateTime);
var Buoni,Ticket:Integer;
begin
  RMProgressivo:=Progressivo;
  try
    if GetBuoniMensaMaturati(RMProgressivo,DaData,AData,DataI,Buoni,Ticket) or RMIgnoraAnomalie then
    begin
      //Registrazione Maturazione su T680 solo se i riepiloghi non sono bloccati
      if RMRegistrazione and
         (DaData = R180InizioMese(DaData)) and (AData = R180FineMese(AData)) and
         (not selDatiBloccati.DatoBloccato(RMProgressivo,R180InizioMese(DataI),'T680')) then
        RegistraMaturazione(RMProgressivo,Buoni,Ticket,DataI);
    end
    else //if Parametri.FileAnomalie <> '' then
      //R180AppendFile(Parametri.FileAnomalie,Format('[Buoni pasto] Matricola: %-8s; Anomalie bloccanti, riepilogo non registrato',[C700SelAnagrafe.FieldByName('MATRICOLA').AsString]));
      if selAnagrafe <> nil then
        RegistraMsg.InserisciMessaggio('A',Format('[Buoni pasto] Matricola: %-8s; Anomalie bloccanti, riepilogo non registrato',[selAnagrafe.FieldByName('MATRICOLA').AsString]),'',RMProgressivo);
  except
    on E:Exception do
      //if Parametri.FileAnomalie <> '' then
      //  R180AppendFile(Parametri.FileAnomalie,Format('[Buoni pasto] Matricola: %-8s; Errore: %s',[C700SelAnagrafe.FieldByName('MATRICOLA').AsString,E.Message]));
      if selAnagrafe <> nil then
        RegistraMsg.InserisciMessaggio('A',Format('[Buoni pasto] Matricola: %-8s; Errore: %s',[selAnagrafe.FieldByName('MATRICOLA').AsString,E.Message]),'',RMProgressivo);
  end;
  SessioneOracleR350.Commit;
end;

function TR350FCalcoloBuoniDtM.GetBuoniMensaMaturati(Prog:Integer; DaData,AData,DataI:TDateTime; var Buoni,Ticket:Integer):Boolean;
{Calcola il numero di buoni mensa/ticket restaurant maturati nel periodo}
var DataCorr:TDateTime;
    A,M,G:Word;
    B,T,MaxMensile,VB,VT:Integer;
    Anom,Msg:String;
begin
  Result:=True;
  DecodeDate(DaData,A,M,G);
  Buoni:=0;
  Ticket:=0;
  MaxMensile:=0;
  QSBuonoMensa.GetDatiStorici('T430' + Parametri.CampiRiferimento.C4_BuoniMensa,Prog,DaData,AData);
  InizializzaRientriPomeridiani(Prog,DaData);
  DataCorr:=DaData;
  while DataCorr <= AData do
  begin
    Msg:=CalcolaBuoni(Prog,DataCorr,B,T,Anom);
    if Anom <> '' then
      Result:=False;
    {$IFNDEF IRISWEB}
    if (Msg <> '') and (Msg <> R350ANOM1) and (Msg <> R350ANOM3) and (Msg <> R350ANOM7) then  //Alberto 03/05/2010: Non si registra il messaggio se regole non trovate
      RegistraMsg.InserisciMessaggio('I',Format('Data: %s; Buono non maturato: %s',[DateToStr(DataCorr),Msg]),'',Prog);
    {$ENDIF}
    if EsisteRegola then
      MaxMensile:=Q670.FieldByName('NUM_MAX_BUONI').AsInteger;
    if (MaxMensile = 0) or (Buoni + Ticket < MaxMensile) then
    begin
      inc(Buoni,B);
      inc(Ticket,T);
      if RMStampa and ((B > 0) or (T > 0) or (Anom <> '')) then
        InserisciDipendente(Prog,B,T,DataCorr,Anom,'N',DataCorr >= DataI);
    end;
    if DataCorr = R180InizioMese(DataCorr) then
    begin
      DecodeDate(DataCorr,A,M,G);
      GetVariazioni(Prog,A,M,VB,VT);
      if RMStampa and ((VB <> 0) or (VT <> 0)) then
        InserisciDipendente(Prog,VB,VT,DataCorr,Anom,'S',DataCorr >= DataI);
    end;
    DataCorr:=DataCorr + 1;
  end;
end;

procedure TR350FCalcoloBuoniDtM.InizializzaRientriPomeridiani(Prog:Integer; Data:TDateTime);
var selT077:TselT077;
begin
  //Leggo dai dati riepilogativi il debito dei rientri per il mese in corso basato sui rientri teorici:
  //su questo debito � sufficiente la regola del rientro obbligatorio
  selT077:=TselT077.Create(nil);
  try
    selT077.Session:=SessioneOracleR350;
    selT077.Progressivo:=Prog;
    selT077.Data:=Data;
    BuoniDaRientriPomeridiani.Obbl:=0;
    BuoniDaRientriPomeridiani.Suppl:=0;
    BuoniDaRientriPomeridiani.Debito:=StrToIntDef(selT077.LeggiValore(I011RIENTRIPOM_TEORICI),0);
  finally
    FreeAndNil(selT077);
  end;
  (*
  //Verifico che il totale dei buoni che hanno rispettato la regola dei rientri non sia minore
  //dei buoni maturati complessivamente, nel qual caso abbatto la maturazione mensile
  BuoniObbl:=min(Debito,BuoniDaRientriPomeridiani.Obbl + BuoniDaRientriPomeridiani.Suppl);
  //I buoni eventualmente maturati in pi� devono rispettare la regola dei rientir supplementari
  BuoniSuppl:=BuoniDaRientriPomeridiani.Obbl + BuoniDaRientriPomeridiani.Suppl - BuoniObbl;
  BuoniSuppl:=min(BuoniSuppl,BuoniDaRientriPomeridiani.Suppl);

  Tot:=BuoniObbl + BuoniSuppl;
  if Tot < Buoni + Ticket then
  begin
    Tot:=Buoni + Ticket - Tot;
    App:=min(Ticket,Tot);
    dec(Ticket,App);
    dec(Tot,App);
    App:=min(Buoni,Tot);
    dec(Buoni,App);
  end;
  *)
end;

procedure TR350FCalcoloBuoniDtM.InserisciDipendente(Prog,Buoni,Ticket:Integer; Data:TDateTime; Anom,Manuale:String; Stampa:Boolean);
begin
  TabellaStampa.Insert;
  if selAnagrafe <> nil then
  begin
    if RMCampoRagg <> '' then
      TabellaStampa.FieldByName('Raggruppamento').AsString:=selAnagrafe.FieldByName(RMCampoRagg).AsString;
    TabellaStampa.FieldByName('Badge').Value:=selAnagrafe.FieldByName('T430Badge').AsInteger;
    TabellaStampa.FieldByName('Matricola').Value:=selAnagrafe.FieldByName('Matricola').AsString;
    TabellaStampa.FieldByName('Nome').AsString:=selAnagrafe.FieldByName('Cognome').AsString + ' ' + selAnagrafe.FieldByName('Nome').AsString;
  end;
  TabellaStampa.FieldByName('Progressivo').AsInteger:=Prog;
  TabellaStampa.FieldByName('Data').AsDateTime:=Data;
  TabellaStampa.FieldByName('Manuale').AsString:=Manuale;
  TabellaStampa.FieldByName('Buoni').Value:=Buoni;
  TabellaStampa.FieldByName('Ticket').Value:=Ticket;
  TabellaStampa.FieldByName('Anomalia').AsString:=Anom;
  TabellaStampa.FieldByName('Stampa').AsBoolean:=Stampa;
  TabellaStampa.Post;
end;

procedure TR350FCalcoloBuoniDtM.RegistraMaturazione(Prog,Buoni,Ticket:LongInt; Data:TDateTime);
begin
  insT680.SetVariable('Progressivo',Prog);
  insT680.SetVariable('Anno',R180Anno(Data));
  insT680.SetVariable('Mese',R180Mese(Data));
  insT680.SetVariable('BuoniPasto',Buoni);
  insT680.SetVariable('Ticket',Ticket);
  try
    insT680.Execute;
    RegistraLog.SettaProprieta('I','T680_BUONIMENSILI','A074',nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Prog));
    RegistraLog.InserisciDato('DATA','',DateToStr(R180InizioMese(Data)));
    RegistraLog.InserisciDato('BUONIPASTO','',IntToStr(Buoni));
    RegistraLog.InserisciDato('TICKET','',IntToStr(Ticket));
    RegistraLog.RegistraOperazione;
  except
  end;
end;

procedure TR350FCalcoloBuoniDtM.RiepilogoMensileAcquisto(Progressivo:Integer; Data:TDateTime);
begin
  RMProgressivo:=Progressivo;
  if CalcolaAcquisto(RMProgressivo,Data,False) then
    if RMStampa and ((RiepilogoBT.Acquisto <> 0) or (RiepilogoBT.RecuperoAtt <> 0) or (RiepilogoBT.RecuperoPrec <> 0)) then
      InserisciAcquisto(RMProgressivo);
  //Effettuo registrazione solo se i riepiloghi non sono bloccati
  if RMRegistrazione and (not selDatiBloccati.DatoBloccato(RMProgressivo,R180InizioMese(Data),'T690')) then
    RegistraAcquisto(RMProgressivo,Data);
end;

procedure TR350FCalcoloBuoniDtM.InserisciAcquisto(Prog:Integer);
begin
  TabellaStampa.Append;
  TabellaStampa.FieldByName('Progressivo').AsInteger:=Prog;
  TabellaStampa.FieldByName('Data').AsDateTime:=Date;  //Non serve, ma da valorizzare poich� entra in chiave primaria
  if selAnagrafe <> nil then
  begin
    if RMCampoRagg <> '' then
      TabellaStampa.FieldByName('Raggruppamento').AsString:=selAnagrafe.FieldByName(RMCampoRagg).AsString;
    TabellaStampa.FieldByName('Badge').Value:=selAnagrafe.FieldByName('T430Badge').AsInteger;
    TabellaStampa.FieldByName('Matricola').Value:=selAnagrafe.FieldByName('Matricola').AsString;
    TabellaStampa.FieldByName('Nome').AsString:=selAnagrafe.FieldByName('Cognome').AsString + ' ' + selAnagrafe.FieldByName('Nome').AsString;
  end;
  with RiepilogoBT do
  begin
    if Tipo = 'B' then
      TabellaStampa.FieldByName('Buoni').Value:=Acquisto
    else
      TabellaStampa.FieldByName('Ticket').Value:=Acquisto;
    TabellaStampa.FieldByName('Tipo').AsString:=Tipo;
    TabellaStampa.FieldByName('RecuperoPrec').Value:=RecuperoPrec;
    TabellaStampa.FieldByName('RecuperoAtt').Value:=RecuperoAtt;
    TabellaStampa.FieldByName('ResiduoPrec').Value:=ResiduoPrec;
    TabellaStampa.FieldByName('ResiduoAtt').Value:=ResiduoAtt;
  end;
  TabellaStampa.Post;
end;

procedure TR350FCalcoloBuoniDtM.RegistraAcquisto(Prog:LongInt; Data:TDateTime);
begin
  insT690.ClearVariables;
  insT690.SetVariable('PROGRESSIVO',Prog);
  insT690.SetVariable('DATA',R180InizioMese(Data));
  with RiepilogoBT do
    if Tipo = 'B' then
    begin
      insT690.SetVariable('BUONI_AUTO',Acquisto);
      insT690.SetVariable('BUONI_RECUPERATI',RecuperoAtt);
      insT690.SetVariable('BUONI_RECUPERATI_PREC',RecuperoPrec);
    end
    else
    begin
      insT690.SetVariable('TICKET_AUTO',Acquisto);
      insT690.SetVariable('TICKET_RECUPERATI',RecuperoAtt);
      insT690.SetVariable('TICKET_RECUPERATI_PREC',RecuperoPrec);
    end;
  try
    insT690.Execute;
    RegistraLog.SettaProprieta('I','T690_ACQUISTOBUONI','A074',nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Prog));
    RegistraLog.InserisciDato('DATA','',DateToStr(R180InizioMese(Data)));
    with RiepilogoBT do
      if Tipo = 'B' then
      begin
        RegistraLog.InserisciDato('BUONI_AUTO','',IntToStr(Acquisto));
        RegistraLog.InserisciDato('BUONI_RECUPERATI','',IntToStr(RecuperoAtt));
        RegistraLog.InserisciDato('BUONI_RECUPERATI_PREC','',IntToStr(RecuperoPrec));
      end
      else
      begin
        RegistraLog.InserisciDato('TICKET_AUTO','',IntToStr(Acquisto));
        RegistraLog.InserisciDato('TICKET_RECUPERATI','',IntToStr(RecuperoAtt));
        RegistraLog.InserisciDato('TICKET_RECUPERATI_PREC','',IntToStr(RecuperoPrec));
      end;
    RegistraLog.RegistraOperazione;
  except
  end;
  SessioneOracleR350.Commit;
end;

procedure TR350FCalcoloBuoniDtM.R350FCalcoloBuoniDtMDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
  FreeAndNil(QSBuonoMensa);
  FreeAndNil(DipendenteInServizio);
  FreeAndNil(selDatiBloccati);
  FreeAndNil(R502ProDtM1);
  if R450DtM1 <> nil then
    FreeAndNil(R450DtM1);
  if R400 <> nil then
    FreeAndNil(R400);
  FreeAndNil(Elenco);
end;

end.
