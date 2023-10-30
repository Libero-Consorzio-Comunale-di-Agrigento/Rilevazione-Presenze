unit W024URichiestaStraordinariDM;

interface

uses
  A000UCostanti,
  A000USessione,
  A000UInterfaccia,
  C018UIterAutDM,
  C180FunzioniGenerali,
  DatiBloccati,
  SysUtils,
  StrUtils,
  Classes,
  Math,
  DB,
  Oracle,
  OracleData,
  Variants;

type
  TevtW024Proc = procedure of object;

  TW024FRichiestaStraordinariDM = class(TDataModule)
    selT070: TOracleDataSet;
    selT820: TOracleDataSet;
    selT820PROGRESSIVO: TIntegerField;
    selT820ANNO: TIntegerField;
    selT820MESE: TIntegerField;
    selT820DAL: TIntegerField;
    selT820AL: TIntegerField;
    selT820CAUSALE: TStringField;
    selT820LIQUIDABILE: TStringField;
    selT820ORE_TEORICHE: TStringField;
    selT820ORE: TStringField;
    selT065: TOracleDataSet;
    selT065DATA: TDateTimeField;
    selT065TIPO: TStringField;
    selT065Desc_Tipo: TStringField;
    selT065ORE_ECCED_CALC: TStringField;
    selT065ORE_ECCEDENTI: TStringField;
    selT065ORE_DACOMPENSARE: TStringField;
    selT065ORE_DALIQUIDARE: TStringField;
    selT065MESSAGGI: TStringField;
    selT065CF_DATA: TStringField;
    selT065CF_ORE_ECCED_VALID: TStringField;
    selT065CF_ORE_COMP_VALID: TStringField;
    selT065CF_ORE_LIQ_VALID: TStringField;
    selT065CF_ORE_ECCEDENTI: TStringField;
    selT065CF_ORE_DACOMPENSARE: TStringField;
    selT065CF_ORE_DALIQUIDARE: TStringField;
    selT065CF_ORE_ECCED_AUTORIZ: TStringField;
    selT065CF_ORE_COMP_AUTORIZ: TStringField;
    selT065CF_ORE_LIQ_AUTORIZ: TStringField;
    selT065CF_ORE_COMPENSABILI_ANNO: TStringField;
    selT065CF_ORE_COMPENSATE_ANNO: TStringField;
    selT065CF_RES_ORE_COMP_ANNO: TStringField;
    selT065CF_ORE_LIQUIDABILI_ANNO: TStringField;
    selT065CF_ORE_LIQUIDATE_ANNO: TStringField;
    selT065CF_RES_ORE_LIQ_ANNO: TStringField;
    selT065CF_RIEP_ORE_COMP: TStringField;
    selT065CF_RIEP_ORE_LIQ: TStringField;
    selT025TipoRichStr: TOracleDataSet;
    selT825: TOracleDataSet;
    selLimitiMensili: TOracleDataSet;
    selT065ID: TFloatField;
    selT065ID_REVOCA: TFloatField;
    selT065ID_REVOCATO: TFloatField;
    selT065PROGRESSIVO: TIntegerField;
    selT065NOMINATIVO: TStringField;
    selT065MATRICOLA: TStringField;
    selT065SESSO: TStringField;
    selT065COD_ITER: TStringField;
    selT065TIPO_RICHIESTA: TStringField;
    selT065AUTORIZZ_AUTOMATICA: TStringField;
    selT065REVOCABILE: TStringField;
    selT065DATA_RICHIESTA: TDateTimeField;
    selT065LIVELLO_AUTORIZZAZIONE: TFloatField;
    selT065DATA_AUTORIZZAZIONE: TDateTimeField;
    selT065AUTORIZZAZIONE: TStringField;
    selT065NOMINATIVO_RESP: TStringField;
    selT065AUTORIZZ_AUTOM_PREV: TStringField;
    selT065AUTORIZZ_PREV: TStringField;
    selT065RESPONSABILE_PREV: TStringField;
    selT065AUTORIZZ_UTILE: TStringField;
    selT065AUTORIZZ_REVOCA: TStringField;
    selT065D_TIPO_RICHIESTA: TStringField;
    selT065D_RESPONSABILE: TStringField;
    selT065D_AUTORIZZAZIONE: TStringField;
    selT025Info: TOracleDataSet;
    selaT820: TOracleDataSet;
    selaT065: TOracleDataSet;
    selT065ID_CONGUAGLIO: TIntegerField;
    selT852: TOracleDataSet;
    selT065ORE_CAUSALIZZATE: TStringField;
    selT065CAUSALE: TStringField;
    selT065CF_CAUSALE_AUTORIZ: TStringField;
    selT065CF_ORE_CAUS_AUTORIZ: TStringField;
    selT065MIN_ORE_DALIQUIDARE: TStringField;
    T065P_GESTIONESTRAORDINARIO: TOracleQuery;
    selT065MIN_ORE_DACOMPENSARE: TStringField;
    selT065MSGAUT_SI: TStringField;
    selT065MSGAUT_NO: TStringField;
    selT065ORE_CAUSALIZZATE_DALIQ: TStringField;
    selT065ORE_CAUSALIZZATE_DACOMP: TStringField;
    selT065CF_ORE_CAUS_DACOMP_AUTORIZ: TStringField;
    selT065CF_ORE_CAUS_DALIQ_AUTORIZ: TStringField;
    selT074: TOracleDataSet;
    selT065MAX_ORE_DALIQUIDARE: TStringField;
    selT065MAX_ORE_CAUSALIZZATE_DALIQ: TStringField;
    selT235: TOracleDataSet;
    selT200: TOracleDataSet;
    delT065: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT065CalcFields(DataSet: TDataSet);
    procedure selT065FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    procedure AutorizzateDelMese(Progressivo:Integer;Data:TDateTime;var OreComp,OreLiq,Causale,OreCaus,OreCausComp,OreCausLiq:String);
    procedure InAutorizzDelMese(Progressivo:Integer;Data:TDateTime;var OreComp,OreLiq,Causale,OreCaus,OreCausComp,OreCausLiq:String);
    function AutorizzazioneManuale(Progressivo:Integer;Data:TDateTime;OreComp,OreLiq,Causale,OreCaus,OreCausComp,OreCausLiq:String):Boolean;
  public
    TipoRichStr: String;
    FiltroNonAutorizzabili: String;
    //GestioneCausale: Boolean; // spostata su form, qui è inutilizzata
    CampiCalcolati: Boolean;
    AggiornaTotali:Boolean;
    C018:TC018FIterAutDM;
    C90_W024MMIndietro,C90_W024MMIndietroRitardo:Integer;
    evtAperturaDataSetIterTemp: TevtW024Proc;
    procedure AperturaDataSetIter(FiltroAnag:String);
    procedure RecuperaLimitiAnnuali(FiltroDip:String;Anno:Integer;var OreComp,OreLiq:String);
    procedure RecuperaLimitiMensili(FiltroDip:String;Data:TDateTime;var OreComp,OreLiq:String);
    procedure LiquidaOre(const PProg: Integer; const PData: TDateTime; const PCausale: String; const PMinuti: Integer);
  end;

implementation

uses
  R400UCartellinoDtM;

{$R *.dfm}

procedure TW024FRichiestaStraordinariDM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;

  C90_W024MMIndietro:=StrToIntDef(Parametri.CampiRiferimento.C90_W024MMIndietro,1);
  C90_W024MMIndietroRitardo:=Max(0,StrToIntDef(Parametri.CampiRiferimento.C90_W024MMIndietroRitardo,0));
  C90_W024MMIndietroRitardo:=C90_W024MMIndietro + C90_W024MMIndietroRitardo;

  // tipo richiesta straordinario
  TipoRichStr:=TTipoRichStrRec.BancaOre;
  selT025TipoRichStr.Open;
  if not selT025TipoRichStr.Eof then
    TipoRichStr:=selT025TipoRichStr.FieldByName('TIPO').AsString;
  selT025TipoRichStr.Close;
end;

procedure TW024FRichiestaStraordinariDM.AperturaDataSetIter(FiltroAnag:String);
var S,FiltroVis,FiltroVisTipo2:String;
begin
  // apertura dataset delle richieste straordinari
  // inizializzazione variabili
  R180SetVariable(selT065,'DATALAVORO',Parametri.DataLavoro);
  R180SetVariable(selT065,'FILTRO_PERIODO',null);
  R180SetVariable(selT065,'FILTRO_ANAG',FiltroAnag);
  FiltroNonAutorizzabili:='( T850.STATO is null and ' +
                          '(   not to_number(to_char(sysdate,''dd'')) between ' + IntToStr(StrToIntDef(Parametri.CampiRiferimento.C90_W026UtilizzoDal,1)) + ' and ' + IntToStr(StrToIntDef(Parametri.CampiRiferimento.C90_W026UtilizzoAl,31)) + ' ' +
                           //Format('OR T_ITER.DATA < ADD_MONTHS(TRUNC(SYSDATE,''MM''),%d) ',[-C90_W024MMIndietro]) +
                           Format('or T_ITER.DATA < add_months(trunc(sysdate,''mm''),%d) ',[IfThen(C018.Responsabile,-C90_W024MMIndietroRitardo,-C90_W024MMIndietro)]) +
                           IfThen(C018.Responsabile,Format('or exists (select 1 from VT065_ITER_RICHIESTESTRAORD where PROGRESSIVO = T_ITER.PROGRESSIVO and T065DATA < T_ITER.DATA and T065DATA >= add_months(trunc(sysdate,''mm''),%d) and T850STATO is null and T850TIPO_RICHIESTA in (''A'',''I'',''V''))',[-C90_W024MMIndietroRitardo])) +
                            'or exists (select 1 from t180_datibloccati ' +
                                       'where riepilogo = ''T820'' ' +
                                       'and stato = ''C'' ' +
                                       'and progressivo = T_ITER.PROGRESSIVO ' +
                                       'and T_ITER.DATA between dal and al)))';
  //Tentativo di ottimizzazione della query usando T430 invece di V430
  WR000DM.TransV430toT430(selT065);

  // aperture temporanee del dataset delle richieste straordinari per estrarre dati utili alla gestione
  if Assigned(evtAperturaDataSetIterTemp) then
    evtAperturaDataSetIterTemp;

  // apertura definitiva
  S:=C018.FiltroRichieste;
  FiltroVisTipo2:='';
  if (TipoRichStr <> TTipoRichStrRec.BancaOre)
  and not (trTutte in C018.TipoRichiesteSel) then
  begin
    if trNonAutorizzabili in C018.TipoRichiesteSel then
      FiltroVisTipo2:=IfThen(S <> '',' or ') + FiltroNonAutorizzabili
    else if (trRichiedibili in C018.TipoRichiesteSel) or
            (trDaAutorizzare in C018.TipoRichiesteSel) or
            (trInAutorizzazione in C018.TipoRichiesteSel) then
      FiltroVisTipo2:=IfThen(S <> '',' and ') + 'not ' + FiltroNonAutorizzabili;
  end;
  FiltroVis:=' and (T850.TIPO_RICHIESTA <> ''C'')';
  if C018.Responsabile then
    FiltroVis:=FiltroVis + ' and (T850.TIPO_RICHIESTA <> ''R'')';
  if (S <> '') or (FiltroVisTipo2 <> '') then
    FiltroVis:=FiltroVis + ' and (' + Copy(S,7,Length(S) - 7) + FiltroVisTipo2 + ')';
  R180SetVariable(selT065,'FILTRO_VISUALIZZAZIONE',FiltroVis);
end;

procedure TW024FRichiestaStraordinariDM.RecuperaLimitiAnnuali(FiltroDip:String;Anno:Integer;var OreComp,OreLiq:String);
begin
  OreComp:='';
  OreLiq:='';
  R180SetVariable(selT825,'FILTRO_DIP',FiltroDip);
  if Pos(':DATALAVORO',UpperCase(FiltroDip)) > 0 then
  begin
    if selT825.VariableIndex('DATALAVORO') = -1 then
      selT825.DeclareVariable('DATALAVORO',otDate);
    R180SetVariable(selT825,'DATALAVORO',Parametri.DataLavoro);
  end
  else if selT825.VariableIndex('DATALAVORO') > -1 then
    selT825.DeleteVariable('DATALAVORO');
  R180SetVariable(selT825,'ANNO',Anno);
  selT825.Open;
  if selT825.FieldByName('NUMERO').AsInteger > 0 then
  begin
    //Per il dipendente prendo i limiti solo se almeno uno è definitivo
    if C018.Responsabile or (selT825.FieldByName('DEFINITIVI').AsString = 'S') then
    begin
      OreComp:=R180MinutiOre(selT825.FieldByName('RESIDUABILE').AsInteger);
      OreLiq:=R180MinutiOre(selT825.FieldByName('LIQUIDABILE').AsInteger);
    end;
  end
  else
  begin
    R180SetVariable(selT200,'PROGRESSIVO', FiltroDip);
    R180SetVariable(selT200,'ANNO', Anno);
    try
      selT200.Open;
      OreComp:=selT200.FieldByName('MAXRESIDUABILE').AsString;
      OreLiq:=selT200.FieldByName('MAXSTRAORD').AsString;
    except
    end;
  end;
end;

procedure TW024FRichiestaStraordinariDM.RecuperaLimitiMensili(FiltroDip:String;Data:TDateTime;var OreComp,OreLiq:String);
begin
  OreComp:='';
  OreLiq:='';
  //Non prelevo i limiti per il mese in lavorazione se è Gennaio, perché D_FIN e FINE finirebbero nell'anno precedente
  if (R180Mese(Data) = 1) and (Data = R180InizioMese(R180AddMesi(Date,-C90_W024MMIndietro))) then
    Exit;
  //Prelevo i totali da inizio anno fino, al massimo, a 2 mesi precedenti a sysdate
  //Se i limiti sono definitivi prelevo dalla scheda riepilogativa, altrimenti dai limiti mensili
  R180SetVariable(selLimitiMensili,'FILTRO_DIP',FiltroDip);
  if Pos(':DATALAVORO',UpperCase(FiltroDip)) > 0 then
  begin
    if selLimitiMensili.VariableIndex('DATALAVORO') = -1 then
      selLimitiMensili.DeclareVariable('DATALAVORO',otDate);
    R180SetVariable(selLimitiMensili,'DATALAVORO',Parametri.DataLavoro);
  end
  else if selLimitiMensili.VariableIndex('DATALAVORO') > -1 then
    selLimitiMensili.DeleteVariable('DATALAVORO');
  R180SetVariable(selLimitiMensili,'ANNO',R180Anno(Data));
  R180SetVariable(selLimitiMensili,'INIZIO',EncodeDate(R180Anno(Data),1,1));
  if Data = R180InizioMese(R180AddMesi(Date,-C90_W024MMIndietro)) then
    R180SetVariable(selLimitiMensili,'FINE',R180InizioMese(R180AddMesi(Date,-C90_W024MMIndietro - 1)))
  else
    R180SetVariable(selLimitiMensili,'FINE',Data);
  selLimitiMensili.Open;
  OreComp:=R180MinutiOre(selLimitiMensili.FieldByName('ORE_RESIDUATE').AsInteger);
  OreLiq:=R180MinutiOre(selLimitiMensili.FieldByName('ORE_LIQUIDATE').AsInteger);
end;

procedure TW024FRichiestaStraordinariDM.AutorizzateDelMese(Progressivo:Integer;Data:TDateTime;var OreComp,OreLiq,Causale,OreCaus,OreCausComp,OreCausLiq:String);
begin
  OreComp:='';
  OreLiq:='';
  Causale:='';
  OreCaus:='';
  OreCausComp:='';
  OreCausLiq:='';
  //Prelevo la somma delle autorizzazioni del mese
  selaT065.Close;
  selaT065.SetVariable('PROGRESSIVO',Progressivo);
  selaT065.SetVariable('DATA',Data);
  selaT065.Open;
  while not selaT065.Eof do
  begin
    if selaT065.FieldByName('STATO').AsString = 'S' then
    begin
      selT852.Close;
      selT852.SetVariable('ID',selaT065.FieldByName('ID').AsInteger);
      selT852.Open;
      while not selT852.Eof do
      begin
        if selT852.FieldByName('DATO').AsString = 'ORE_DACOMPENSARE' then
          OreComp:=R180MinutiOre(R180OreMinuti(OreComp) + R180OreMinuti(selT852.FieldByName('VALORE').AsString))
        else if selT852.FieldByName('DATO').AsString = 'ORE_DALIQUIDARE' then
          OreLiq:=R180MinutiOre(R180OreMinuti(OreLiq) + R180OreMinuti(selT852.FieldByName('VALORE').AsString))
        else if selT852.FieldByName('DATO').AsString = 'CAUSALE' then
          Causale:=selT852.FieldByName('VALORE').AsString
        else if selT852.FieldByName('DATO').AsString = 'ORE_CAUSALIZZATE' then
          OreCaus:=R180MinutiOre(R180OreMinuti(OreCaus) + R180OreMinuti(selT852.FieldByName('VALORE').AsString))
        else if selT852.FieldByName('DATO').AsString = 'ORE_CAUSALIZZATE_DACOMP' then
          OreCausComp:=R180MinutiOre(R180OreMinuti(OreCausComp) + R180OreMinuti(selT852.FieldByName('VALORE').AsString))
        else if selT852.FieldByName('DATO').AsString = 'ORE_CAUSALIZZATE_DALIQ' then
          OreCausLiq:=R180MinutiOre(R180OreMinuti(OreCausLiq) + R180OreMinuti(selT852.FieldByName('VALORE').AsString));
        selT852.Next;
      end;
    end
    else if selaT065.FieldByName('STATO').AsString = 'N' then
    begin
      OreComp:=R180MinutiOre(R180OreMinuti(OreComp) + 0);
      OreLiq:=R180MinutiOre(R180OreMinuti(OreLiq) + 0);
      if not selaT065.FieldByName('CAUSALE').IsNull then
      begin
        Causale:=selaT065.FieldByName('CAUSALE').AsString;
        OreCaus:=R180MinutiOre(R180OreMinuti(OreCaus) + 0);
        OreCausComp:=R180MinutiOre(R180OreMinuti(OreCausComp) + 0);
        OreCausLiq:=R180MinutiOre(R180OreMinuti(OreCausLiq) + 0);
      end;
    end;
    selaT065.Next;
  end;
  //Potrebbe essere stato salvato 0 in Ore_Causalizzate, ma equivale a vuoto, per il successivo controllo sui limiti
  if Causale = '' then
  begin
    OreCaus:='';
    OreCausComp:='';
    OreCausLiq:='';
  end;
end;

procedure TW024FRichiestaStraordinariDM.InAutorizzDelMese(Progressivo:Integer;Data:TDateTime;var OreComp,OreLiq,Causale,OreCaus,OreCausComp,OreCausLiq:String);
begin
  OreComp:='';
  OreLiq:='';
  Causale:='';
  OreCaus:='';
  OreCausComp:='';
  OreCausLiq:='';
  //Prelevo la somma delle richieste in autorizzazione del mese
  selaT065.First;
  while not selaT065.Eof do
  begin
    if R180In(selaT065.FieldByName('TIPO_RICHIESTA').AsString,['A','I']) then
    begin
      //il dipendente non deve vedere le quantità impostate dal responsabile finché non autorizza
      if (selaT065.FieldByName('TIPO_RICHIESTA').AsString = 'A') or not C018.Responsabile then
      begin
        OreComp:=R180MinutiOre(R180OreMinuti(OreComp) + R180OreMinuti(selaT065.FieldByName('ORE_DACOMPENSARE').AsString));
        OreLiq:=R180MinutiOre(R180OreMinuti(OreLiq) + R180OreMinuti(selaT065.FieldByName('ORE_DALIQUIDARE').AsString));
        if not selaT065.FieldByName('CAUSALE').IsNull then
        begin
          Causale:=selaT065.FieldByName('CAUSALE').AsString;
          OreCaus:=R180MinutiOre(R180OreMinuti(OreCaus) + R180OreMinuti(selaT065.FieldByName('ORE_CAUSALIZZATE').AsString));
          OreCausComp:=R180MinutiOre(R180OreMinuti(OreCausComp) + R180OreMinuti(selaT065.FieldByName('ORE_CAUSALIZZATE_DACOMP').AsString));
          OreCausLiq:=R180MinutiOre(R180OreMinuti(OreCausLiq) + R180OreMinuti(selaT065.FieldByName('ORE_CAUSALIZZATE_DALIQ').AsString));
        end;
      end
      else
      begin
        selT852.Close;
        selT852.SetVariable('ID',selaT065.FieldByName('ID').AsInteger);
        selT852.Open;
        while not selT852.Eof do
        begin
          if selT852.FieldByName('DATO').AsString = 'ORE_DACOMPENSARE' then
            OreComp:=R180MinutiOre(R180OreMinuti(OreComp) + R180OreMinuti(selT852.FieldByName('VALORE').AsString))
          else if selT852.FieldByName('DATO').AsString = 'ORE_DALIQUIDARE' then
            OreLiq:=R180MinutiOre(R180OreMinuti(OreLiq) + R180OreMinuti(selT852.FieldByName('VALORE').AsString))
          else if selT852.FieldByName('DATO').AsString = 'CAUSALE' then
            Causale:=selT852.FieldByName('VALORE').AsString
          else if selT852.FieldByName('DATO').AsString = 'ORE_CAUSALIZZATE' then
            OreCaus:=R180MinutiOre(R180OreMinuti(OreCaus) + R180OreMinuti(selT852.FieldByName('VALORE').AsString))
          else if selT852.FieldByName('DATO').AsString = 'ORE_CAUSALIZZATE_DACOMP' then
            OreCausComp:=R180MinutiOre(R180OreMinuti(OreCausComp) + R180OreMinuti(selT852.FieldByName('VALORE').AsString))
          else if selT852.FieldByName('DATO').AsString = 'ORE_CAUSALIZZATE_DALIQ' then
            OreCausLiq:=R180MinutiOre(R180OreMinuti(OreCausLiq) + R180OreMinuti(selT852.FieldByName('VALORE').AsString));
          selT852.Next;
        end;
      end;
    end;
    selaT065.Next;
  end;
end;

procedure TW024FRichiestaStraordinariDM.LiquidaOre(const PProg: Integer; const PData: TDateTime; const PCausale: String; const PMinuti: Integer);
var
  LMinutiResidui: Integer;
  LMinutiPresenza: Integer;
  LLiquidato: Integer;
  LArrotCausLiqFasce: String;
  LMinutiArrotCausLiq: Integer;
begin
  // se non ci sono minuti da liquidare non effettua operazioni
  if PMinuti = 0 then
    Exit;

  // estrae informazioni sulla causale di presenza per la liquidazione
  if TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
  begin
    R180SetVariable(selT235,'CODICE',PCausale);
    R180SetVariable(selT235,'DATA',R180FineMese(PData));
    selT235.Open;
    if selT235.RecordCount > 0 then
    begin
      LMinutiArrotCausLiq:=R180OreMinuti(selT235.FieldByName('ITER_AUTSTR_ARROT_LIQ').AsString);
      LArrotCausLiqFasce:=selT235.FieldByName('ITER_AUTSTR_ARROT_LIQ_FASCE').AsString
    end
    else
    begin
      raise Exception.CreateFmt('Liquidazione impossibile: nessuna informazione sulla causale di presenza %s al %s',[PCausale,FormatDateTime('dd/mm/yyyy',R180FineMese(PData))]);
    end;
  end;

  // imposta una variabile contenente i minuti residui da liquidare
  LMinutiResidui:=PMinuti;

  // liquida il numero di minuti indicato valorizzando i dati su T074_CAUSPRESFASCE
  // la liquidazione viene effettuata nelle fasce in cui c'è disponibilità di T074.OREPRESENZA,
  // partendo dalla maggiorazione più alta
  selT074.Close;
  selT074.SetVariable('PROGRESSIVO',PProg);
  selT074.SetVariable('DATA',PData);
  selT074.SetVariable('CAUSALE',PCausale);
  selT074.Open;
  while (not selT074.Eof) and (LMinutiResidui > 0) do
  begin
    LMinutiPresenza:=R180OreMinuti(selT074.FieldByName('OREPRESENZA').AsString);

    // se ci sono ore di presenza nella fascia, determina il valore da liquidare
    if LMinutiPresenza > 0 then
    begin
      // determina il numero di ore da liquidare sulla fascia di maggiorazione
      LLiquidato:=Min(LMinutiResidui,LMinutiPresenza);

      // se la causale prevede lo prevede, applica l'arrotondamento sulle singole fasce
      if (LArrotCausLiqFasce = 'S') and (LMinutiArrotCausLiq > 1) then
        LLiquidato:=Trunc(R180Arrotonda(LLiquidato,LMinutiArrotCausLiq,'D'));

      // imposta le ore liquidate, sovrascrivendo l'eventuale valore già presente
      selT074.Edit;
      selT074.FieldByName('LIQUIDATO').AsString:=R180MinutiOre(LLiquidato);
      selT074.Post;

      // aggiorna i minuti residui da liquidare
      LMinutiResidui:=LMinutiResidui - LLiquidato;
    end;

    selT074.Next;
  end;
  selT074.Close;
end;

function TW024FRichiestaStraordinariDM.AutorizzazioneManuale(Progressivo:Integer;Data:TDateTime;OreComp,OreLiq,Causale,OreCaus,OreCausComp,OreCausLiq:String):Boolean;
var TrovComp,TrovLiq,TrovCaus:Boolean;
begin
  Result:=False;
  TrovComp:=False;
  TrovLiq:=False;
  TrovCaus:=False;
  //Prelevo i limiti mensili
  selaT820.Close;
  selaT820.SetVariable('PROGRESSIVO',Progressivo);
  selaT820.SetVariable('ANNO',R180Anno(Data));
  selaT820.SetVariable('MESE',R180Mese(Data));
  selaT820.Open;
  while not selaT820.Eof do
  begin
    //Verifico il limite sul compensabile
    if (selaT820.FieldByName('CAUSALE').AsString = '* B')
    and (selaT820.FieldByName('LIQUIDABILE').AsString = 'N') then
    begin
      TrovComp:=True;
      Result:=R180MinutiOre(R180OreMinuti(selaT820.FieldByName('ORE').AsString)) <> OreComp;
    end
    //Verifico il limite sul liquidabile
    else if (selaT820.FieldByName('CAUSALE').AsString = '* L')
    and (selaT820.FieldByName('LIQUIDABILE').AsString = 'S') then
    begin
      TrovLiq:=True;
      Result:=R180MinutiOre(R180OreMinuti(selaT820.FieldByName('ORE').AsString)) <> OreLiq;
    end
    //Verifico il limite sulla causale
    else if (Causale <> '')
    and (selaT820.FieldByName('CAUSALE').AsString = Causale)
    and (selaT820.FieldByName('LIQUIDABILE').AsString = 'S') then
    begin
      TrovCaus:=True;
      Result:=R180MinutiOre(R180OreMinuti(selaT820.FieldByName('ORE').AsString)) <> OreCaus;
    end
    //C'è una situazione sui limiti che non mi aspettavo
    else
      Result:=True;
    //Se c'è stato un intervento manuale esco dal ciclo e poi dalla funzione
    if Result then
      Break;
    selaT820.Next;
  end;
  //Se non esiste un limite che mi aspettavo, allora c'è stato un intervento manuale (da operatore lato IrisWin)
  Result:=Result or
          ((not TrovComp) and (OreComp <> '')) or
          ((not TrovLiq) and (OreLiq <> '')) or
          ((not TrovCaus) and (OreCaus <> ''));
end;

procedure TW024FRichiestaStraordinariDM.selT065CalcFields(DataSet: TDataSet);
var sOreComp,sOreLiq:String;
    sCausale,sOreCaus,sOreCausComp,sOreCausLiq:String;
    CompDelMese,LiqDelMese,CausDelMeseAut,CausDelMeseInAut:Integer;
  function CausaleNelBudget(C:String):Boolean;
  var _Filtered:Boolean;
  begin
    Result:=False;
    if C = '' then
      exit;
    _Filtered:=WR000DM.selT275.Filtered;
    try
      WR000DM.selT275.Filtered:=False;
      if VarToStr(WR000DM.selT275.Lookup('CODICE',C,'ORENORMALI')) <> 'A' then
        //Ore incluse nelle normali: sono sempre incluse nel budget (?)
        Result:=True
      else if (VarToStr(WR000DM.selT275.Lookup('CODICE',C,'ABBATTE_BUDGET')) = 'L') and
              (VarToStr(WR000DM.selT275.Lookup('CODICE',C,'NO_LIMITE_ANNUALE_LIQ')) = 'N') then
        //Ore escluse dalle normali: sono sempre incluse nel budget (?)
        Result:=True;
    finally
      WR000DM.selT275.Filtered:=_Filtered;
    end;
  end;
begin
  if CampiCalcolati then
  begin
    selT065.FieldByName('Desc_Tipo').AsString:=IfThen(selT065.FieldByName('TIPO').AsString = 'C','Corrente','Conguaglio');
    //Imposto lo stato fittizio "Non autorizzabile" per lo Straordinario annuo:
    //Stato non impostato e ((Richiesta più vecchia del mese precedente a sysdate) o (Periodo abilitato scaduto) o (Blocchi sui riepiloghi))
    if (TipoRichStr <> TTipoRichStrRec.BancaOre) and (selT065.FieldByName('AUTORIZZAZIONE').IsNull) then
    begin
      if selT065.FieldByName('DATA').AsDateTime < R180InizioMese(R180AddMesi(Date,IfThen(C018.Responsabile,-C90_W024MMIndietroRitardo,-C90_W024MMIndietro))) then
      begin
        selT065.FieldByName('D_Tipo_Richiesta').AsString:='X';
        selT065.FieldByName('D_Avvertimenti').AsString:='Mese non più ' + IfThen(selT065.FieldByName('TIPO_RICHIESTA').AsString = 'R','richiedibile','autorizzabile') + ' via web';
      end
      else if not R180Between(R180Giorno(Date),StrToIntDef(Parametri.CampiRiferimento.C90_W026UtilizzoDal,1),StrToIntDef(Parametri.CampiRiferimento.C90_W026UtilizzoAl,31)) then
      begin
        selT065.FieldByName('D_Tipo_Richiesta').AsString:='X';
        selT065.FieldByName('D_Avvertimenti').AsString:=FormatDateTime('dd/mm/yyyy',Date) + ' esterno al periodo di ' + IfThen(selT065.FieldByName('TIPO_RICHIESTA').AsString = 'R','richiesta','autorizzazione');
      end
      else if WR000DM.selDatiBloccati.DatoBloccato(selT065.FieldByName('PROGRESSIVO').AsInteger,selT065.FieldByName('DATA').AsDateTime,'T820') then
      begin
        selT065.FieldByName('D_Tipo_Richiesta').AsString:='X';
        selT065.FieldByName('D_Avvertimenti').AsString:='Saldi mensili non modificabili';
      end;
    end;
    if selT065.FieldByName('D_Tipo_Richiesta').IsNull then
      selT065.FieldByName('D_Tipo_Richiesta').AsString:=selT065.FieldByName('TIPO_RICHIESTA').AsString;
    selT065.FieldByName('D_Responsabile').AsString:=Trim(selT065.FieldByName('NOMINATIVO_RESP').AsString);
    selT065.FieldByName('D_Autorizzazione').AsString:=IfThen(selT065.FieldByName('AUTORIZZAZIONE').AsString = 'S','Si',IfThen(selT065.FieldByName('AUTORIZZAZIONE').AsString = 'N','No',''));
    selT065.FieldByName('CF_Data').AsString:=FormatDateTime('mm/yyyy',selT065.FieldByName('DATA').AsDateTime);
  end;
  if CampiCalcolati or AggiornaTotali then
  begin
    C018.CodIter:=selT065.FieldByName('COD_ITER').AsString;
    C018.Id:=selT065.FieldByName('ID').AsInteger;
    //Prelevo i dati di validazione e autorizzazione
    if C018.EsisteFase[T065FASE_VALIDAZIONE] then
    begin
      selT065.FieldByName('CF_ORE_ECCED_VALID').AsString:=C018.GetDatoAutorizzatore('ORE_ECCEDENTI','1').Valore;
      selT065.FieldByName('CF_ORE_COMP_VALID').AsString:=C018.GetDatoAutorizzatore('ORE_DACOMPENSARE','1').Valore;
      selT065.FieldByName('CF_ORE_LIQ_VALID').AsString:=C018.GetDatoAutorizzatore('ORE_DALIQUIDARE','1').Valore;
      (*
      selT065.FieldByName('CF_CAUSALE_VALID').AsString:=C018.GetDatoAutorizzatore('CAUSALE','1').Valore;
      selT065.FieldByName('CF_ORE_CAUS_VALID').AsString:=C018.GetDatoAutorizzatore('ORE_CAUSALIZZATE','1').Valore;
      selT065.FieldByName('CF_ORE_CAUS_DACOMP_VALID').AsString:=C018.GetDatoAutorizzatore('ORE_CAUSALIZZATE_DACOMP','1').Valore;
      selT065.FieldByName('CF_ORE_CAUS_DALIQ_VALID').AsString:=C018.GetDatoAutorizzatore('ORE_CAUSALIZZATE_DALIQ','1').Valore;
      *)
      selT065.FieldByName('CF_ORE_ECCED_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE_ECCEDENTI','2').Valore;
      selT065.FieldByName('CF_ORE_COMP_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE_DACOMPENSARE','2').Valore;
      selT065.FieldByName('CF_ORE_LIQ_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE_DALIQUIDARE','2').Valore;
      selT065.FieldByName('CF_CAUSALE_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('CAUSALE','2').Valore;
      selT065.FieldByName('CF_ORE_CAUS_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE_CAUSALIZZATE','2').Valore;
      selT065.FieldByName('CF_ORE_CAUS_DACOMP_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE_CAUSALIZZATE_DACOMP','2').Valore;
      selT065.FieldByName('CF_ORE_CAUS_DALIQ_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE_CAUSALIZZATE_DALIQ','2').Valore;
    end
    else
    begin
      selT065.FieldByName('CF_ORE_ECCED_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE_ECCEDENTI','1').Valore;
      selT065.FieldByName('CF_ORE_COMP_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE_DACOMPENSARE','1').Valore;
      selT065.FieldByName('CF_ORE_LIQ_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE_DALIQUIDARE','1').Valore;
      selT065.FieldByName('CF_CAUSALE_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('CAUSALE','1').Valore;
      selT065.FieldByName('CF_ORE_CAUS_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE_CAUSALIZZATE','1').Valore;
      selT065.FieldByName('CF_ORE_CAUS_DACOMP_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE_CAUSALIZZATE_DACOMP','1').Valore;
      selT065.FieldByName('CF_ORE_CAUS_DALIQ_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE_CAUSALIZZATE_DALIQ','1').Valore;
    end;
    //Per il Validatore imposto i dati della richiesta ancora da validare
    if (C018.FaseLivello[selT065.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger] = 1) and (selT065.FieldByName('D_TIPO_RICHIESTA').AsString = 'A') then
    begin
      selT065.FieldByName('CF_ORE_ECCED_VALID').AsString:=selT065.FieldByName('ORE_ECCEDENTI').AsString;
      selT065.FieldByName('CF_ORE_COMP_VALID').AsString:=selT065.FieldByName('ORE_DACOMPENSARE').AsString;
      selT065.FieldByName('CF_ORE_LIQ_VALID').AsString:=selT065.FieldByName('ORE_DALIQUIDARE').AsString;
      (*
      selT065.FieldByName('CF_CAUSALE_VALID').AsString:=selT065.FieldByName('CAUSALE').AsString;
      selT065.FieldByName('CF_ORE_CAUS_VALID').AsString:=selT065.FieldByName('ORE_CAUSALIZZATE').AsString;
      selT065.FieldByName('CF_ORE_CAUS_DACOMP_VALID').AsString:=selT065.FieldByName('ORE_CAUSALIZZATE_DACOMP').AsString;
      selT065.FieldByName('CF_ORE_CAUS_DALIQ_VALID').AsString:=selT065.FieldByName('ORE_CAUSALIZZATE_DALIQ').AsString;
      *)
    end;
    //Aggiorno i dati di autorizzazione in base allo stato reale della richiesta (altrimenti, per lo stato fittizio X, non saprebbe quali dati prendere)
    selT065.FieldByName('CF_ORE_ECCED_AUTORIZ').AsString:=IfThen(selT065.FieldByName('TIPO_RICHIESTA').AsString = 'A',selT065.FieldByName('ORE_ECCEDENTI').AsString,IfThen(selT065.FieldByName('TIPO_RICHIESTA').AsString = 'V',selT065.FieldByName('CF_ORE_ECCED_VALID').AsString,selT065.FieldByName('CF_ORE_ECCED_AUTORIZ').AsString));
    selT065.FieldByName('CF_ORE_COMP_AUTORIZ').AsString:=IfThen(selT065.FieldByName('TIPO_RICHIESTA').AsString = 'A',selT065.FieldByName('ORE_DACOMPENSARE').AsString,IfThen(selT065.FieldByName('TIPO_RICHIESTA').AsString = 'V',selT065.FieldByName('CF_ORE_COMP_VALID').AsString,selT065.FieldByName('CF_ORE_COMP_AUTORIZ').AsString));
    selT065.FieldByName('CF_ORE_LIQ_AUTORIZ').AsString:=IfThen(selT065.FieldByName('TIPO_RICHIESTA').AsString = 'A',selT065.FieldByName('ORE_DALIQUIDARE').AsString,IfThen(selT065.FieldByName('TIPO_RICHIESTA').AsString = 'V',selT065.FieldByName('CF_ORE_LIQ_VALID').AsString,selT065.FieldByName('CF_ORE_LIQ_AUTORIZ').AsString));
    selT065.FieldByName('CF_CAUSALE_AUTORIZ').AsString:=IfThen(selT065.FieldByName('TIPO_RICHIESTA').AsString = 'A',selT065.FieldByName('CAUSALE').AsString,selT065.FieldByName('CF_CAUSALE_AUTORIZ').AsString);
    selT065.FieldByName('CF_ORE_CAUS_AUTORIZ').AsString:=IfThen(selT065.FieldByName('TIPO_RICHIESTA').AsString = 'A',selT065.FieldByName('ORE_CAUSALIZZATE').AsString,selT065.FieldByName('CF_ORE_CAUS_AUTORIZ').AsString);
    selT065.FieldByName('CF_ORE_CAUS_DACOMP_AUTORIZ').AsString:=IfThen(selT065.FieldByName('TIPO_RICHIESTA').AsString = 'A',selT065.FieldByName('ORE_CAUSALIZZATE_DACOMP').AsString,selT065.FieldByName('CF_ORE_CAUS_DACOMP_AUTORIZ').AsString);
    selT065.FieldByName('CF_ORE_CAUS_DALIQ_AUTORIZ').AsString:=IfThen(selT065.FieldByName('TIPO_RICHIESTA').AsString = 'A',selT065.FieldByName('ORE_CAUSALIZZATE_DALIQ').AsString,selT065.FieldByName('CF_ORE_CAUS_DALIQ_AUTORIZ').AsString);
  end;
  if CampiCalcolati then
  begin
    if TipoRichStr <> TTipoRichStrRec.BancaOre then
    begin
      //Avvertimento di Autorizzazione manuale
      AutorizzateDelMese(selT065.FieldByName('PROGRESSIVO').AsInteger,selT065.FieldByName('DATA').AsDateTime,sOreComp,sOreLiq,sCausale,sOreCaus,sOreCausComp,sOreCausLiq);
      CompDelMese:=IfThen(selT065.FieldByName('DATA').AsDateTime = R180InizioMese(R180AddMesi(Date,-C90_W024MMIndietro)),R180OreMinuti(sOreComp),0);
      LiqDelMese:=IfThen(selT065.FieldByName('DATA').AsDateTime = R180InizioMese(R180AddMesi(Date,-C90_W024MMIndietro)),R180OreMinuti(sOreLiq),0);
      CausDelMeseAut:=IfThen(selT065.FieldByName('DATA').AsDateTime = R180InizioMese(R180AddMesi(Date,-C90_W024MMIndietro)),
                             R180OreMinuti(IfThen(TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp,sOreCausLiq,sOreCaus)),
                             0);
      if CausaleNelBudget(sCausale) then
        LiqDelMese:=LiqDelMese + CausDelMeseAut;
      selT065.FieldByName('D_Avvertimenti').AsString:=Trim(selT065.FieldByName('D_Avvertimenti').AsString + CRLF + IfThen(AutorizzazioneManuale(selT065.FieldByName('PROGRESSIVO').AsInteger,selT065.FieldByName('DATA').AsDateTime,sOreComp,sOreLiq,sCausale,sOreCaus,sOreCausComp,sOreCausLiq),'Esiste autorizzazione manuale'));
      //Recupero i limiti annuali
      RecuperaLimitiAnnuali('= ' + selT065.FieldByName('PROGRESSIVO').AsString,R180Anno(selT065.FieldByName('DATA').AsDateTime),sOreComp,sOreLiq);
      selT065.FieldByName('CF_Ore_Compensabili_Anno').AsString:=sOreComp;
      selT065.FieldByName('CF_Ore_Liquidabili_Anno').AsString:=sOreLiq;
      //Se ho recuperato dei limiti...(quindi sempre tranne che dipendente senza limiti definitivi)
      if selT065.FieldByName('CF_Ore_Compensabili_Anno').AsString <> '' then
      begin
        //Calcolo le quantità richieste/autorizzate del mese precedente a sysdate (escludo le richieste R,X,N perché non contengono ore autorizzate o in attesa di autorizzazione)
        if (selT065.FieldByName('DATA').AsDateTime = R180InizioMese(R180AddMesi(Date,-C90_W024MMIndietro)))
        and (R180Between(R180Giorno(Date),StrToIntDef(Parametri.CampiRiferimento.C90_W026UtilizzoDal,1),StrToIntDef(Parametri.CampiRiferimento.C90_W026UtilizzoAl,31)))
        and (not WR000DM.selDatiBloccati.DatoBloccato(selT065.FieldByName('PROGRESSIVO').AsInteger,selT065.FieldByName('DATA').AsDateTime,'T820'))
        then
        begin
          InAutorizzDelMese(selT065.FieldByName('PROGRESSIVO').AsInteger,selT065.FieldByName('DATA').AsDateTime,sOreComp,sOreLiq,sCausale,sOreCaus,sOreCausComp,sOreCausLiq);
          CompDelMese:=CompDelMese + R180OreMinuti(sOreComp);
          LiqDelMese:=LiqDelMese + R180OreMinuti(sOreLiq);
          CausDelMeseInAut:=R180OreMinuti(IfThen(TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp,sOreCausLiq,sOreCaus));
          if CausaleNelBudget(sCausale) then
            LiqDelMese:=LiqDelMese + CausDelMeseInAut;
        end;
        //Assegno i totali, eventualmente aggiungendo le quantità richieste/autorizzate del mese precedente a sysdate
        RecuperaLimitiMensili('= ' + selT065.FieldByName('PROGRESSIVO').AsString,selT065.FieldByName('DATA').AsDateTime,sOreComp,sOreLiq);
        selT065.FieldByName('CF_Ore_Compensate_Anno').AsString:=R180MinutiOre(R180OreMinuti(sOreComp) + CompDelMese);
        selT065.FieldByName('CF_Res_Ore_Comp_Anno').AsString:=R180MinutiOre(R180OreMinuti(selT065.FieldByName('CF_Ore_Compensabili_Anno').AsString) - R180OreMinuti(selT065.FieldByName('CF_Ore_Compensate_Anno').AsString));
        selT065.FieldByName('CF_Ore_Liquidate_Anno').AsString:=R180MinutiOre(R180OreMinuti(sOreLiq) + LiqDelMese);
        selT065.FieldByName('CF_Res_Ore_Liq_Anno').AsString:=R180MinutiOre(R180OreMinuti(selT065.FieldByName('CF_Ore_Liquidabili_Anno').AsString) - R180OreMinuti(selT065.FieldByName('CF_Ore_Liquidate_Anno').AsString));
        //Visualizzo i totali in un'unica colonna
        selT065.FieldByName('CF_Riep_Ore_Comp').AsString:=selT065.FieldByName('CF_Ore_Compensabili_Anno').AsString.Trim + ' ' + selT065.FieldByName('CF_Ore_Compensate_Anno').AsString.Trim + ' ' + selT065.FieldByName('CF_Res_Ore_Comp_Anno').AsString.Trim;
        selT065.FieldByName('CF_Riep_Ore_Liq').AsString:=selT065.FieldByName('CF_Ore_Liquidabili_Anno').AsString.Trim + ' ' + selT065.FieldByName('CF_Ore_Liquidate_Anno').AsString.Trim + ' ' + selT065.FieldByName('CF_Res_Ore_Liq_Anno').AsString.Trim;
      end;
    end;
    //In caso di dipendente o validatore, se la riga non è ancora stata autorizzata, svuoto i campi di autorizzazione (che mi servivano per i calcolare totali dello Straordinario annuo)
    if (C018.FaseLivello[selT065.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger] <> 2)
    and not R180In(selT065.FieldByName('D_TIPO_RICHIESTA').AsString,['S','N']) then
    begin
      selT065.FieldByName('CF_ORE_ECCED_AUTORIZ').AsString:='';
      selT065.FieldByName('CF_ORE_COMP_AUTORIZ').AsString:='';
      selT065.FieldByName('CF_ORE_LIQ_AUTORIZ').AsString:='';
      selT065.FieldByName('CF_CAUSALE_AUTORIZ').AsString:='';
      selT065.FieldByName('CF_ORE_CAUS_AUTORIZ').AsString:='';
      selT065.FieldByName('CF_ORE_CAUS_DACOMP_AUTORIZ').AsString:='';
      selT065.FieldByName('CF_ORE_CAUS_DALIQ_AUTORIZ').AsString:='';
    end;
  end;
end;

procedure TW024FRichiestaStraordinariDM.selT065FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=selT065.FieldByName('DATA').AsDateTime <= R180AddMesi(R180InizioMese(Date),-C90_W024MMIndietro);
end;

end.
