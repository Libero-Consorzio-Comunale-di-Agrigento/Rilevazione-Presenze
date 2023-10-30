unit A173UImportAssestamentoMW;

interface

uses
  R005UDataModuleMW, Forms, Classes, DB, OracleData, SysUtils, StrUtils, Math,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, A000USessione, A029ULiquidazione, R450, C180FunzioniGenerali,
  C004UParamForm, System.Generics.Collections, FunzioniGenerali, Oracle;

type
  TInfoUltimaOperazione = class
  private
    // variabili di comodo e metodi
    FC004: TC004FParamForm;
  public
    Utente: String;
    Data: TDateTime;
    Importazione: String;
    Operazione: String;
    NomeFile: String;
    constructor Create(PSessioneOracle: TOracleSession);
    destructor Destroy; override;
    procedure SetInfo(PUtente: String; PData: TDateTime; PImportazione: String; POperazione: String; PNomeFile: String);
    procedure Carica;
    procedure Salva;
    function Verifica(PTipoOperazione, PNomeFile: String): TResCtrl;
  end;

  TA173FImportAssestamentoMW = class(TR005FDataModuleMW)
    selT030: TOracleDataSet;
    selT305: TOracleDataSet;
    selT070: TOracleDataSet;
    selT071: TOracleDataSet;
    updT071: TOracleQuery;
    selT030a: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    R450DtM1:TR450DtM1;
    A029FLiquidazione: TA029FLiquidazione;
    FUltimaOperazione: TInfoUltimaOperazione;
    function ControllaAnno(pAnno: string): Boolean;
    function ControllaOreMinuti(pOre, pMinuti: string): Boolean;
    function ControllaMese(pMese: string): Boolean;
    function ElaboraAssestamento(const PTipoElab: String; const PModificaEsistente: Boolean;
                                 Matricola: string; Anno, Mese: string; Causale: string; LNumMinutiAst : array of integer): Boolean;
    function ElaboraLiquidazione(const PTipoElab: String; const PModificaEsistente: Boolean;
                                 Matricola: string; Anno, Mese: string; LNumMinutiAst : array of integer): Boolean;
    function EstraiProgressivo(pMatricola: string): integer;
    function EstraiMatricola(pCodFiscale: string; pData: TDateTime; pCercaCessati: Boolean): string;
    function LeggiRiga(var sRigaIn: string): Boolean;
    function VerificaCausale(pCausale: string; pMatr: string): Boolean;
  public
    nNumRiga,nTotRighe:integer;
    FIn: TextFile;
    procedure ApriFile(NomeFile: String);
    procedure RecuperaTotaleRigheFile(pTipoImpo: string);
    procedure ElaboraRigaOreLiquidate(const PTipoElab: String; const PModificaEsistente: Boolean);
    procedure ElaboraRigaOreAssestamento(const PTipoElab: String; const PModificaAssEsistente: Boolean; PIdCodFiscale, PCercaCessati:Boolean);
    property UltimaOperazione: TInfoUltimaOperazione read FUltimaOperazione;
  end;

implementation

{$R *.dfm}

function TA173FImportAssestamentoMW.ControllaAnno(pAnno: string): Boolean;
begin
  if (pAnno < '1900') or (pAnno > '3999') then
  begin
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_NO_ANNO,[inttostr(nNumRiga),pAnno]));
    Result:=False;
  end
  else
    Result:=True;
end;

function TA173FImportAssestamentoMW.ControllaMese(pMese: string): Boolean;
begin
  if (pMese < '01') or (pMese > '12') then
  begin
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_NO_MESE,[inttostr(nNumRiga),pMese]));
    Result:=False;
  end
  else
    Result:=True;
end;

function TA173FImportAssestamentoMW.ControllaOreMinuti(pOre, pMinuti: string): Boolean;
begin
  Result:=True;
  if (pOre < '000') or (pOre > '999') then
  begin
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_NO_ORE,[inttostr(nNumRiga),pOre]));
    Result:=False;
  end;
  if (pMinuti < '00') or (pMinuti > '59') then
  begin
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_NO_MINUTI,[inttostr(nNumRiga),pMinuti]));
    Result:=False;
  end;
end;

procedure TA173FImportAssestamentoMW.DataModuleCreate(Sender: TObject);
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  inherited;

  // oggetto che contiene le informazioni dell'ultima elaborazione effettuata
  FUltimaOperazione:=TInfoUltimaOperazione.Create(SessioneOracle);
end;

procedure TA173FImportAssestamentoMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FUltimaOperazione);
  FreeAndNil(R450DtM1);
  FreeAndNil(A029FLiquidazione);
  inherited;
end;

procedure TA173FImportAssestamentoMW.ApriFile(NomeFile:String);
begin
  try
    AssignFile(FIn, NomeFile);
    Reset(FIn);
  except
    raise Exception.Create(Format(A000MSG_ERR_FMT_APRI_FILE,[NomeFile]));
  end;
end;

procedure TA173FImportAssestamentoMW.RecuperaTotaleRigheFile(pTipoImpo: string);
var sRigaIn: String;
    NSeparatori:Integer;
begin
  nTotRighe:=0;
  while not System.Eof(FIn) do
  begin
    Readln(FIn,sRigaIn);
    nTotRighe:=nTotRighe + 1;
    NSeparatori:=0;
    while Pos(';',sRigaIn) > 0 do
    begin
      inc(NSeparatori);
      sRigaIn:=Copy(sRigaIn,Pos(';',sRigaIn)+1);
    end;
    if ((pTipoImpo = 'A') and (NSeparatori <> 6)) or
       ((pTipoImpo = 'L') and (not R180In(NSeparatori,[6,11]))) then
    begin
      CloseFile(FIn);
      raise exception.Create(A000MSG_A173_ERR_COLONNE_FILE);
    end;
  end;
  CloseFile(FIn);
end;

function TA173FImportAssestamentoMW.VerificaCausale(pCausale: string; pMatr: string): Boolean;
var LProg: integer;
begin
  LProg:=EstraiProgressivo(pMatr);
  if LProg = 0 then
  begin
    Result:=False;
    Exit;
  end;
  // verifica esistenza causale
  selT305.Close;
  selT305.SetVariable('CAUSALE',pCausale);
  selT305.Open;
  if selT305.Eof then
  begin
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_NO_CAUSALE,[inttostr(nNumRiga),pCausale]),'',LProg);
    Result:=False;
  end
  else
    Result:=True;
end;

function TA173FImportAssestamentoMW.LeggiRiga(var sRigaIn: string) : Boolean;
var
 S2: string;
 RigaVuota: Boolean;
begin
  nNumRiga:=nNumRiga + 1;
  Readln(FIn,sRigaIn);
  sRigaIn:=sRigaIn + ';';

  //Se la riga è vuota, la salto
  S2:=sRigaIn;
  RigaVuota:=True;
  while Pos(';',S2) > 0 do
  begin
    if Trim(Copy(S2,1,Pos(';',S2) - 1)) <> '' then
    begin
      RigaVuota:=False;
      Break;
    end;
    S2:=Copy(S2,Pos(';',S2) + 1);
  end;

  result:=not RigaVuota;
end;

procedure TA173FImportAssestamentoMW.ElaboraRigaOreLiquidate(const PTipoElab: String; const PModificaEsistente: Boolean);
function ControllaOreMinuti(pMinuti: integer;  pStrOre : string; pValoriNeg: Boolean = False): Boolean;
begin  //Controlla che le ore passate siano inferiori a 1000
  Result:=True;
  if ((pMinuti < 0) and (not pValoriNeg)) or
     ((pMinuti < -59999) and pValoriNeg) or
     (pMinuti > 59999) then
  begin
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_NO_ORE,[inttostr(nNumRiga),pStrOre]));
    Result:=False;
  end;
end;
var
  sRigaIn, Matricola: string;
  Anno, Mese, Causale: string;

  //Straordinari
  strOra: array[1..4] of string;
  LNumMinutistr: array[1..4] of integer;
  //Assestamento
  astOra: array[1..4] of string;
  LNumMinutiAst: array[1..4] of integer;
  Fascia: Integer;
begin
  if not LeggiRiga(sRigaIn) then
    Exit;

  // estrae i dati dalla riga
  Matricola:=Trim(Copy(sRigaIn,1,Pos(';',sRigaIn)-1));
  sRigaIn:=Copy(sRigaIn,Pos(';',sRigaIn)+1);
  Anno:=Trim(Copy(sRigaIn,1,Pos(';',sRigaIn)-1));
  sRigaIn:=Copy(sRigaIn,Pos(';',sRigaIn)+1);
  Mese:=Format('%2.2d',[StrToInt(Trim(Copy(sRigaIn,1,Pos(';',sRigaIn)-1)))]);
  sRigaIn:=Copy(sRigaIn,Pos(';',sRigaIn)+1);

  for Fascia:=Low(strOra) to High(strOra) do  //Ore straordinario
  begin
    strOra[Fascia]:=Trim(Copy(sRigaIn,1,Pos(';',sRigaIn)-1));
    sRigaIn:=Copy(sRigaIn,Pos(';',sRigaIn)+1);
  end;

  Causale:=Trim(Copy(sRigaIn,1,Pos(';',sRigaIn)-1));
  sRigaIn:=Copy(sRigaIn,Pos(';',sRigaIn)+1);

  for Fascia:=Low(astOra) to High(astOra) do  //Ore assestamento
  begin
    astOra[Fascia]:=Trim(Copy(sRigaIn,1,Pos(';',sRigaIn)-1));
    sRigaIn:=Copy(sRigaIn,Pos(';',sRigaIn)+1);
  end;

  // controlla i dati
  for Fascia:=Low(strOra) to High(strOra) do
    if (strOra[Fascia] <> '') and (not OreMinutiValidate(strOra[Fascia])) then
    begin
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_ORE,[inttostr(nNumRiga),Matricola,Mese,Anno]),'',EstraiProgressivo(Matricola));
      Exit;
    end;
  for Fascia:=Low(astOra) to High(astOra) do
    if (astOra[Fascia] <> '') and (not OreMinutiValidate(astOra[Fascia])) then
    begin
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_ORE,[inttostr(nNumRiga),Matricola,Mese,Anno]),'',EstraiProgressivo(Matricola));
      Exit;
    end;

  // converte i dati nei tipi corretti
  for Fascia:=Low(strOra) to High(strOra) do
    LNumMinutiStr[Fascia]:=R180OreMinuti(strOra[Fascia]);
  for Fascia:=Low(astOra) to High(astOra) do
    LNumMinutiAst[Fascia]:=R180OreMinuti(astOra[Fascia]);

  //Controlla valori accettabili
  for Fascia:=Low(strOra) to High(strOra) do
    if not ControllaOreMinuti(LNumMinutiStr[Fascia],strOra[Fascia],False) then
      Exit;
  for Fascia:=Low(astOra) to High(astOra) do
    if not ControllaOreMinuti(LNumMinutiAst[Fascia],astOra[Fascia],True) then
      Exit;

  if (Causale <> '') and VerificaCausale(Causale, Matricola) then
    ElaboraAssestamento(PTipoElab, PModificaEsistente, Matricola, Anno, Mese, Causale, LNumMinutiAst);

  ElaboraLiquidazione(PTipoElab, PModificaEsistente, Matricola, Anno, Mese, LNumMinutiStr);
end;

function TA173FImportAssestamentoMW.ElaboraAssestamento(const PTipoElab: String; const PModificaEsistente: Boolean;
                                                        Matricola: string; Anno, Mese: string; Causale: string; LNumMinutiAst : array of integer): Boolean;

var
  LProg: Integer;
  LCampoCaus, LCaus, LCampoOre: string;
  LOldMinuti, LNewMinuti, LMinutiRes: Integer;
  DataMese: TDateTime;
  Fascia: integer;
begin
  Result:=False;

  // controlla i dati
  if not ControllaAnno(Anno) then
    Exit;
  if not ControllaMese(Mese) then
    Exit;

  LProg:=EstraiProgressivo(Matricola);
  if LProg = 0 then
    exit;

  //Se tutti i valori sono uguali 0, esco subito
  if (MinIntValue(LNumMinutiAst) = 0) and (MaxIntValue(LNumMinutiAst) = 0) then
    exit;

  // converte i dati nei tipi corretti
  DataMese:=R180InizioMese(EncodeDate(StrToInt(Anno),StrToInt(Mese),1));

  // verifica esistenza scheda riepilogativa del mese
  R180SetVariable(selT070,'PROG',LProg);
  R180SetVariable(selT070,'DATA',DataMese);
  selT070.Open;
  if selT070.RecordCount > 0 then
  begin
    // apre il dataset per l'aggiornamento
    R180SetVariable(selT071,'PROG',LProg);
    R180SetVariable(selT071,'DATA',DataMese);
    selT071.Open;
    selT071.First;

    if PTipoElab = 'I' then
    begin
      // inserisce assestamento ore
      if (not R180In(Trim(selT070.FieldByName('CAUSALE1MINASS').AsString),['',Causale])) and
         (not R180In(Trim(selT070.FieldByName('CAUSALE2MINASS').AsString),['',Causale])) then
      begin
        //Anomalia bloccante
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_TROPPE_CAUSALI,[inttostr(nNumRiga),Matricola,Mese,Anno]),'',LProg);
        Exit;
      end;

      // controlli per assestamento negativo
      if SumInt(LNumMinutiAst) < 0 then
      begin
        if R450DtM1 = nil then
          R450DtM1:=TR450DtM1.Create(nil);
        R450DtM1.ResetConteggi; //Reset da eventuali conteggi precedenti
        R450DtM1.ConteggiMese('Generico',R180Anno(DataMese),R180Mese(DataMese),LProg);
        if (R450DtM1.salannoatt + SumInt(LNumMinutiAst) < 0) then  //CUNEO_ASLCN1 - 163281 era: if (SumInt(LNumMinutiAst) > R450DtM1.salannoatt) then
          //Anomalia supero saldo complessivo
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_SUPERO_SALDO_COMP,[inttostr(nNumRiga),Matricola,Mese,Anno]),'',LProg)
        else if (R450DtM1.salcompannoatt + R450DtM1.salliqannoatt + SumInt(LNumMinutiAst) < 0) then  //CUNEO_ASLCN1 - 163281 era: else if (SumInt(LNumMinutiAst) > R450DtM1.salcompannoatt + R450DtM1.salliqannoatt) then
          //Anomalia supero saldo anno corrente
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_SUPERO_SALDO_CORR,[inttostr(nNumRiga),Matricola,Mese,Anno]),'',LProg);
      end;

      LCampoCaus:='';
      if selT070.FieldByName('CAUSALE1MINASS').AsString = Causale then
        LCampoCaus:='CAUSALE1MINASS'
      else if selT070.FieldByName('CAUSALE2MINASS').AsString = Causale then
        LCampoCaus:='CAUSALE2MINASS'
      else if selT070.FieldByName('CAUSALE1MINASS').AsString = '' then
        LCampoCaus:='CAUSALE1MINASS'
      else if selT070.FieldByName('CAUSALE2MINASS').AsString = '' then
        LCampoCaus:='CAUSALE2MINASS';

      LCaus:=selT070.FieldByName(LCampoCaus).AsString.Trim;
      begin
        // aggiorna le ore di assestamento sulla T071
        LCampoOre:=IfThen(LCampoCaus = 'CAUSALE1MINASS','ORE1ASSEST','ORE2ASSEST');

        // aggiorna la causale di assestamento sulla T070
        if selT070.FieldByName(LCampoCaus).AsString = '' then
        begin
          selT070.Edit;
          selT070.FieldByName(LCampoCaus).AsString:=Causale;
          RegistraLog.SettaProprieta('M','T070_SCHEDARIEPIL',NomeOwner,selT070,True);
          selT070.Post;
          RegistraLog.RegistraOperazione;
        end;

        // aggiorna il valore di assestamento sulla T071
        RegistraLog.SettaProprieta('M','T071_SCHEDAFASCE',NomeOwner,selT071,True);
        for Fascia:=Low(LNumMinutiAst) to High(LNumMinutiAst) do
        begin
          // determina il nuovo valore di assestamento
          LOldMinuti:=R180OreMinutiExt(selT071.FieldByName(LCampoOre).AsString);
          LNewMinuti:=IfThen(PModificaEsistente,LOldMinuti,0) + LNumMinutiAst[Fascia];
          selT071.Edit;
          selT071.FieldByName(LCampoOre).AsString:=R180MinutiOre(LNewMinuti);
          selT071.Post;
          selT071.Next;
          if selT071.Eof then
            Break;
        end;
        RegistraLog.RegistraOperazione;
      end;
    end
    else
    begin
      //Cancellazione assestamento ore
      if (Trim(selT070.FieldByName('CAUSALE1MINASS').AsString) <> Causale) and
         (Trim(selT070.FieldByName('CAUSALE2MINASS').AsString) <> Causale) then
      begin
        //Anomalia bloccante in cancellazione per causale non corrispondente
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_CANC_NO_CAUSALE,[inttostr(nNumRiga),Matricola,Mese,Anno]),'',LProg);
        Exit;
      end;

      if selT070.FieldByName('CAUSALE2MINASS').AsString = Causale then
        LCampoCaus:='CAUSALE2MINASS'
      else if selT070.FieldByName('CAUSALE1MINASS').AsString = Causale then
        LCampoCaus:='CAUSALE1MINASS';

      LCampoOre:=IfThen(LCampoCaus = 'CAUSALE1MINASS','ORE1ASSEST','ORE2ASSEST');

      LMinutiRes:=0;
      RegistraLog.SettaProprieta(IfThen(PModificaEsistente,'M','C'),'T071_SCHEDAFASCE',NomeOwner,selT071,True);
      for Fascia:=Low(LNumMinutiAst) to High(LNumMinutiAst) do
      begin
        if PModificaEsistente or
          (R180OreMinutiExt(selT071.FieldByName(LCampoOre).AsString) = LNumMinutiAst[Fascia]) then
        begin
          // determina il nuovo valore di assestamento
          LOldMinuti:=R180OreMinutiExt(selT071.FieldByName(LCampoOre).AsString);
          LNewMinuti:=IfThen(PModificaEsistente, LOldMinuti - LNumMinutiAst[Fascia], 0);
          // aggiorna il valore di assestamento sulla T071
          selT071.Edit;
          selT071.FieldByName(LCampoOre).AsString:=R180MinutiOre(LNewMinuti);
          selT071.Post;
        end
        else if not PModificaEsistente then
        begin
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_CANC_NO_ORE,[inttostr(nNumRiga),Matricola,Mese,Anno,selT071.FieldByName(LCampoOre).AsString,R180Minutiore(LNumMinutiAst[Fascia])]),'',LProg);
        end;
        LMinutiRes:=LMinutiRes + R180OreMinuti(selT071.FieldByName(LCampoOre).AsString);
        selT071.Next;
        if selT071.Eof then
          Break;
      end;
      RegistraLog.RegistraOperazione;
      //Leggo eventuali altre fasce della T071 non considerate dal csv
      while not selT071.Eof do
      try
        LMinutiRes:=LMinutiRes + R180OreMinuti(selT071.FieldByName(LCampoOre).AsString);
      finally
        selT071.Next;
      end;

      // aggiorna la causale di assestamento sulla T070 --> solo se i minuti sono a 0
      if LMinutiRes = 0 then
      begin
        selT070.Edit;
        selT070.FieldByName(LCampoCaus).AsString:=IfThen(LNewMinuti = 0,'',Causale);
        RegistraLog.SettaProprieta(IfThen(PModificaEsistente,'M','C'),'T070_SCHEDARIEPIL',NomeOwner,selT070,True);
        selT070.Post;
        RegistraLog.RegistraOperazione;
      end;
    end;
  end
  else
  begin
    //Anomalia bloccante
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_NO_SCHEDA_RIEP,[inttostr(nNumRiga),Matricola,Mese,Anno]),'',LProg);
    Exit;
  end;
  Result:=True;
end;

function TA173FImportAssestamentoMW.ElaboraLiquidazione(const PTipoElab: String; const PModificaEsistente: Boolean;
                                                        Matricola: string; Anno, Mese: string; LNumMinutiAst : array of integer): Boolean;
var
  LProg,LLiq: Integer;
  DataMese: TDateTime;
  Fascia: integer;
begin
  Result:=False;

  // controlla i dati
  if not ControllaAnno(Anno) then
    Exit;
  if not ControllaMese(Mese) then
    Exit;

  LProg:=EstraiProgressivo(Matricola);
  if LProg = 0 then
    exit;

  //Se tutti i valori sono uguali 0, esco subito
  if (MinIntValue(LNumMinutiAst) = 0) and (MaxIntValue(LNumMinutiAst) = 0) then
    exit;

  // converte i dati nei tipi corretti
  DataMese:=R180InizioMese(EncodeDate(StrToInt(Anno),StrToInt(Mese),1));

  // verifica esistenza scheda riepilogativa del mese
  R180SetVariable(selT070,'PROG',LProg);
  R180SetVariable(selT070,'DATA',DataMese);
  selT070.Open;
  if selT070.RecordCount > 0 then
  begin
    // apre il dataset per l'aggiornamento
    R180SetVariable(selT071,'PROG',LProg);
    R180SetVariable(selT071,'DATA',DataMese);
    selT071.Open;
    selT071.First;

    if R450DtM1 = nil then
      R450DtM1:=TR450DtM1.Create(nil);
    if A029FLiquidazione = nil then
    begin
      A029FLiquidazione:=TA029FLiquidazione.Create(nil);
      A029FLiquidazione.R450DtM:=R450DtM1;
    end;
    A029FLiquidazione.Q071Liq.SetVariable('Progressivo',LProg);
    R450DtM1.ResetConteggi; //Reset da eventuali conteggi precedenti
    R450DtM1.ConteggiMese('Generico',R180Anno(DataMese),R180Mese(DataMese),LProg);

    if PTipoElab = 'I' then
    begin
      if SumInt(LNumMinutiAst) > (R450DtM1.salliqannoatt + IfThen(PModificaEsistente,0,R450DtM1.totliqmm)) then
      begin
        //Anomalia: straordinario supera il saldo liquidabile dell'anno corrente
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_LIQ_SUPERO_SALDO_LIQ,[inttostr(nNumRiga),Matricola,Mese,Anno,R180MinutiOre(SumInt(LNumMinutiAst)),R180MinutiOre(R450DtM1.salliqannoatt)]),'',LProg);
        exit;
      end;

      RegistraLog.SettaProprieta('M','T071_SCHEDAFASCE',NomeOwner,selT071,True);
      for Fascia:=Low(LNumMinutiAst) to High(LNumMinutiAst) do
      begin
        //Gestisco la colonna T071.ORESTRAORDLIQ
        LLiq:=Trunc(LNumMinutiAst[Fascia]);
        if not PModificaEsistente then
          dec(LLiq,R180OreMinuti(selT071.FieldByName('LIQUIDNELMESE').AsString));
        A029FLiquidazione.Liquidazione(False,DataMese,LProg,selT071.FieldByName('MAGGIORAZIONE').AsInteger,LLiq,selT071.FieldByName('CODFASCIA').AsString);
        //Gestisco la colonna T071.LIQUIDNELMESE
        selT071.RefreshRecord;
        selT071.Edit;
        selT071.FieldByName('LIQUIDNELMESE').AsString:=R180MinutiOre(IfThen(PModificaEsistente,R180OreMinuti(selT071.FieldByName('LIQUIDNELMESE').AsString)) + Trunc(LNumMinutiAst[Fascia]));
        selT071.Post;
        selT071.Next;
        if selT071.Eof then
          Break;
      end;
      RegistraLog.RegistraOperazione;
    end
    else if PTipoElab = 'C' then
    begin
      if (SumInt(LNumMinutiAst) > R450DtM1.totliqmm)
      or (not PModificaEsistente and (SumInt(LNumMinutiAst) <> R450DtM1.totliqmm)) then
      begin
        //Anomalia: straordinario da abbattere supera/è diverso dal saldo liquidato nel meese corrente
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_CANC_NO_ORE_LIQ,[inttostr(nNumRiga),Matricola,Mese,Anno,R180MinutiOre(R450DtM1.totliqmm),R180MinutiOre(SumInt(LNumMinutiAst))]),'',LProg);
        exit;
      end;

      RegistraLog.SettaProprieta('C','T071_SCHEDAFASCE',NomeOwner,selT071,True);
      for Fascia:=Low(LNumMinutiAst) to High(LNumMinutiAst) do
      begin
        if (PModificaEsistente or
            (R180OreMinutiExt(selT071.FieldByName('LIQUIDNELMESE').AsString) = LNumMinutiAst[Fascia]))
           and
           (R180OreMinutiExt(selT071.FieldByName('LIQUIDNELMESE').AsString) >= LNumMinutiAst[Fascia])
        then
        begin
          //Gestisco la colonna T071.ORESTRAORDLIQ
          LLiq:=-Trunc(LNumMinutiAst[Fascia]);
          A029FLiquidazione.Liquidazione(False,DataMese,LProg,selT071.FieldByName('MAGGIORAZIONE').AsInteger,LLiq,selT071.FieldByName('CODFASCIA').AsString);
          //Gestisco la colonna T071.LIQUIDNELMESE
          selT071.RefreshRecord;
          selT071.Edit;
          selT071.FieldByName('LIQUIDNELMESE').AsString:=R180MinutiOre(IfThen(PModificaEsistente,R180OreMinuti(selT071.FieldByName('LIQUIDNELMESE').AsString),LNumMinutiAst[Fascia]) - LNumMinutiAst[Fascia]);
          selT071.Post;
        end
        else
        begin
          //Anomalia bloccante in cancellazione per ore non corrispondenti
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_CANC_NO_ORE_LIQ,[inttostr(nNumRiga),Matricola,Mese,Anno,selT071.FieldByName('LIQUIDNELMESE').AsString,R180MinutiOre(LNumMinutiAst[Fascia])]),'',LProg);
          //Exit;
        end;
        selT071.Next;
        if selT071.Eof then
          Break;
      end;
      RegistraLog.RegistraOperazione;
    end;
  end
  else
  begin
    //Anomalia bloccante
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_NO_SCHEDA_RIEP,[inttostr(nNumRiga),Matricola,Mese,Anno]),'',LProg);
    Exit;
  end;
  Result:=True;
end;


procedure TA173FImportAssestamentoMW.ElaboraRigaOreAssestamento(const PTipoElab: String; const PModificaAssEsistente: Boolean; PIdCodFiscale, PCercaCessati:Boolean);
var
  sRigaIn,Matricola,LSegno,Ore,Minuti,Causale,Anno,Mese: String;
  DataMese:TDateTime;
  LNumMinuti: array[1..1] of integer;
begin
  if not LeggiRiga(sRigaIn) then
    Exit;

  // estrae i dati dalla riga
  Matricola:=Trim(Copy(sRigaIn,1,Pos(';',sRigaIn)-1));
  sRigaIn:=Copy(sRigaIn,Pos(';',sRigaIn)+1);
  Anno:=Trim(Copy(sRigaIn,1,Pos(';',sRigaIn)-1));
  sRigaIn:=Copy(sRigaIn,Pos(';',sRigaIn)+1);
  Mese:=Format('%2.2d',[StrToInt(Trim(Copy(sRigaIn,1,Pos(';',sRigaIn)-1)))]);
  sRigaIn:=Copy(sRigaIn,Pos(';',sRigaIn)+1);
  LSegno:=Trim(Copy(sRigaIn,1,Pos(';',sRigaIn)-1));
  if LSegno <> '-' then
    LSegno:='0';
  sRigaIn:=Copy(sRigaIn,Pos(';',sRigaIn)+1);
  Ore:=Format('%3.3d',[StrToInt(Trim(Copy(sRigaIn,1,Pos(';',sRigaIn)-1)))]);
  sRigaIn:=Copy(sRigaIn,Pos(';',sRigaIn)+1);
  Minuti:=Format('%2.2d',[StrToInt(Trim(Copy(sRigaIn,1,Pos(';',sRigaIn)-1)))]);
  sRigaIn:=Copy(sRigaIn,Pos(';',sRigaIn)+1);
  Causale:=Trim(Copy(sRigaIn,1,Pos(';',sRigaIn)-1));

  //Ricerca della matricola per codice fiscale (indicato nella colonna in cui solitamente ci sarebbe la matricola)
  if PIdCodFiscale then
  begin
    try
      DataMese:=R180FineMese(EncodeDate(StrToInt(Anno),StrToInt(Mese),1));
    except
      DataMese:=R180FineMese(Parametri.DataLavoro);
    end;
    Matricola:=EstraiMatricola(Matricola,DataMese,PCercaCessati);
    if Matricola = '' then
      exit;
  end;

  // controlla i dati
  if not ControllaOreMinuti(Ore, Minuti) then
    Exit;

  // converte i dati nei tipi corretti
  LNumMinuti[1]:=R180OreMinutiExt(Ore + '.' + Minuti);
  If LSegno <> '0' then
    LNumMinuti[1]:=-LNumMinuti[1];

  if not VerificaCausale(Causale, Matricola) then
    exit;

  if not ElaboraAssestamento(PTipoElab, PModificaAssEsistente, Matricola, Anno, Mese, Causale, LNumMinuti) then
    Exit;
end;

function TA173FImportAssestamentoMW.EstraiProgressivo(pMatricola: string): integer;
begin
  // estrae progressivo
  selT030.Close;
  selT030.SetVariable('MATRICOLA',pMatricola);
  selT030.Open;
  if not selT030.Eof then
    Result:=selT030.FieldByName('PROGRESSIVO').AsInteger
  else
  begin
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_NO_MATRICOLA,[inttostr(nNumRiga),pMatricola]));
    Result:=0;
  end;
end;

function TA173FImportAssestamentoMW.EstraiMatricola(pCodFiscale: string; pData: TDateTime; pCercaCessati: Boolean): string;
var DIni,DFin:TDateTime;
    Cessato,SceltiInServizio:Boolean;
    LProg:Integer;
begin
  Result:='';
  SceltiInServizio:=False;
  // estrae matricola
  selT030a.Close;
  selT030a.SetVariable('CODFISCALE',pCodFiscale);
  selT030a.SetVariable('DATA',pData);
  selT030a.SetVariable('CESSATI',IfThen(pCercaCessati,'S','N'));
  selT030a.Open;
  while not selT030a.Eof  do
  begin
    if selT030a.FieldByName('INIZIO').IsNull then
      DIni:=EncodeDate(3999,12,31)
    else
      DIni:=selT030a.FieldByName('INIZIO').AsDateTime;
    if selT030a.FieldByName('FINE').IsNull then
      DFin:=EncodeDate(3999,12,31)
    else
      DFin:=selT030a.FieldByName('FINE').AsDateTime;
    Cessato:=(pData < R180InizioMese(DIni)) or (pData > R180FineMese(DFin));
    if not Cessato or not SceltiInServizio then //Elenco i cessati solo se non ho già trovato qualcuno in servizio
    begin
      if not Cessato and not SceltiInServizio then
      begin
        SceltiInServizio:=True;
        Result:='';
      end;
      Result:=Result + IfThen(Result <> '',',') + selT030a.FieldByName('MATRICOLA').AsString;
    end;
    selT030a.Next;
  end;
  if Result = '' then
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_NO_CODFISCALE,[inttostr(nNumRiga),pCodFiscale]))
  else if Pos(',',Result) > 0 then
  begin
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_PIU_CODFISCALE,[inttostr(nNumRiga),pCodFiscale,IfThen(SceltiInServizio,'in servizio','tutti cessati')]));
    Result:='';
  end
  else if not SceltiInServizio then
  begin
    LProg:=EstraiProgressivo(Result);
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_CESS_CODFISCALE,[inttostr(nNumRiga),pCodFiscale]),'',LProg);
  end;
end;

{ TInfoUltimaOperazione }

constructor TInfoUltimaOperazione.Create(PSessioneOracle: TOracleSession);
begin
  // crea oggetto per lettura parametri da db
  FC004:=CreaC004(PSessioneOracle,'A173',-1,False);

  // carica info da db
  Carica;
end;

destructor TInfoUltimaOperazione.Destroy;
begin
  FreeAndNil(FC004);
  inherited;
end;

procedure TInfoUltimaOperazione.Carica;
var
  LDataStr: String;
begin
  Utente:=FC004.GetParametro('ULTIMA_OP_UTENTE','');
  LDataStr:=FC004.GetParametro('ULTIMA_OP_DATA','');
  if LDataStr = '' then
    Data:=DATE_NULL
  else if not TryStrToDateTime(LDataStr,Data) then
    Data:=DATE_NULL;
  Importazione:=FC004.GetParametro('ULTIMA_OP_IMPORTAZIONE','A');
  Operazione:=FC004.GetParametro('ULTIMA_OP_TIPO','');
  NomeFile:=FC004.GetParametro('ULTIMA_OP_NOME_FILE','');
end;

procedure TInfoUltimaOperazione.SetInfo(PUtente: String; PData: TDateTime;
  PImportazione, POperazione, PNomeFile: String);
begin
  Utente:=PUtente;
  Data:=PData;
  Importazione:=PImportazione;
  Operazione:=POperazione;
  NomeFile:=PNomeFile;
end;

procedure TInfoUltimaOperazione.Salva;
begin
  FC004.Cancella001;
  FC004.PutParametro('ULTIMA_OP_UTENTE',Utente);
  FC004.PutParametro('ULTIMA_OP_DATA',Data.ToString);
  FC004.PutParametro('ULTIMA_OP_IMPORTAZIONE',Importazione);
  FC004.PutParametro('ULTIMA_OP_TIPO',Operazione);
  FC004.PutParametro('ULTIMA_OP_NOME_FILE',NomeFile);
end;

function TInfoUltimaOperazione.Verifica(PTipoOperazione: String; PNomeFile: String): TResCtrl;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  if (Operazione = PTipoOperazione) and
     (NomeFile.ToUpper = PNomeFile.ToUpper) then
  begin
    Result.Messaggio:=Format('Attenzione!'#13#10'L''operatore %s ha effettuato la'#13#10 +
                             '%s di un file con lo stesso nome'#13#10'in data %s.'#13#10 +
                             'Vuoi continuare?',
                             [Utente,
                              IfThen(Operazione = 'I','registrazione','cancellazione'),
                              Data.ToString]);
    Exit;
  end;

  // controlli ok
  Result.Ok:=True;
end;

end.
