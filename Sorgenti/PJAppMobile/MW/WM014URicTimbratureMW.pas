unit WM014URicTimbratureMW;

interface

uses
  A000UCostanti,
  B110UClientModule,
  B110USharedTypes,
  C200UWebServicesTypes, C200UWebServicesUtils,
  WM000UConstants, WR002URichiesteMW, WM000UDataSetMW,
  Data.FireDACJSONReflect,
  FireDAC.Comp.Client,
  System.Generics.Collections,
  System.Sensors, System.SysUtils, System.Classes,
  System.StrUtils, FunzioniGenerali, System.Math, Data.DB, Variants;

type

  TOperazioneTimbratura = (Nuova, Modifica, Elimina);

  TWM014FRicTimbratureMW = class(TWR002FRichiesteMW)
    private
      FDatiTimb: TDatiRichiestaTimb;
      FOperazioneTimbratura: TOperazioneTimbratura;

      function GetTimbratura: String;
      function GetTimbraturaOrig: String;
      function GetOperazione: String;
      function GetOperazioneEstesa: String;
    public
      constructor Create;
      destructor Destroy; override;

      property DatiTimbratura: TDatiRichiestaTimb read FDatiTimb write FDatiTimb;
      property OperazioneTimbratura: TOperazioneTimbratura read FOperazioneTimbratura;

      property Timbratura: String read GetTimbratura;
      property TimbraturaOrig: String read GetTimbraturaOrig;
      property Operazione: String read GetOperazione;
      property OperazioneEstesa: String read GetOperazioneEstesa;

      procedure ResetOperazioneTimbratura(POperazione: TOperazioneTimbratura; PProgressivo: Integer; PData: TDateTime; POra, PVerso, PRilevatore, PCausale: String);

      function AggiornaRichiesteSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl; override;
      function EliminaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl; override;
      function InserisciRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl; override;

      function AutorizzaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PAut: String): TResCtrl; override;
      function RevocaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl; override;

      function GetCausaliTimbraturaRichiedibiliSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PResultList: TList<TPair<String, String>>): TResCtrl;
      function GetRilevatoriRichiedibiliSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PResultList: TList<TPair<String, String>>): TResCtrl;
      function GetMotivazioniTimbraturaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PResultList: TList<TPair<String, String>>; var PDefaultCode: String): TResCtrl;
      function GetRilevatoriSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PResultList: TList<TPair<String, String>>): TResCtrl;
      function GetCausaliTimbraturaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PResultList: TList<TPair<String, String>>): TResCtrl;
  end;

implementation

constructor TWM014FRicTimbratureMW.Create;
begin
  inherited Create(tdFDMemTable);
  FIter:=ITER_TIMBR;
  FDatiTimb:=TDatiRichiestaTimb.Create;
end;

destructor TWM014FRicTimbratureMW.Destroy;
begin
  FreeAndNil(FDatiTimb);
  inherited;
end;

function TWM014FRicTimbratureMW.AggiornaRichiesteSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): TResCtrl;
var
  LRes: TRisultato;
  LDataSetList: TFDJSONDataSets;
begin
  try
    FDMemTable.Close;

    // estrae l'elenco delle timbrature da autorizzare
    LRes:=B110.B110FServerMethodsDMClient.RichiesteTimbDip(InfoClient.PrepareForServer,
                                                           ParametriLogin.PrepareForServer,
                                                           FFiltriRichieste.Clone,
                                                           '');
    Result:=LRes.Check(TOutputRichiesteTimbDip);
    if Result.Ok then
    begin
        try
          LDataSetList:=(LRes.Output as TOutputRichiesteTimbDip).JSONDatasets;

          // elenco richieste
          FDMemTable.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
          FDMemTable.IndexFieldNames:='NOMINATIVO;MATRICOLA;DATA:D;ORA;DATA_RICHIESTA:D';

          // altri parametri
          RichiesteTotali:=((LRes.Output as TOutputRichiesteTimbDip).RichiesteTotali);
          C018Revocabile:=((LRes.Output as TOutputRichiesteTimbDip).C018Revocabile);
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

function TWM014FRicTimbratureMW.InserisciRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl;
var LRes: TRisultato;
begin
  try
    // inserimento richiesta server
    LRes:=B110.B110FServerMethodsDMClient.InsRichiestaTimb(InfoClient.PrepareForServer, ParametriLogin.PrepareForServer, FDatiTimb.Clone, '');

    // verifica risultato
    //if Assigned(LRes.Output) then
    //  PRisposteMsg:=(LRes.Output as TOutputInsRichiestaTimb).RisposteMsg.Clone;

    Result:=LRes.Check(TOutputInsRichiestaTimb);
    if Result.Ok then
      PRisposteMsg:=(LRes.Output as TOutputInsRichiestaTimb).RisposteMsg.Clone
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

function TWM014FRicTimbratureMW.EliminaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl;
var LRes: TRisultato;
begin
  try
    LRes:=B110.B110FServerMethodsDMClient.CancRichiestaTimb(InfoClient.PrepareForServer,
                                                            ParametriLogin.PrepareForServer,
                                                            ID,
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

function TWM014FRicTimbratureMW.RevocaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl;
begin
  raise Exception.Create('Funzione RevocaRichiesta non implementata');
end;

function TWM014FRicTimbratureMW.AutorizzaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PAut: String): TResCtrl;
begin
  raise Exception.Create('Funzione AutorizzaRichiesta non implementata');
end;

procedure TWM014FRicTimbratureMW.ResetOperazioneTimbratura(POperazione: TOperazioneTimbratura; PProgressivo: Integer; PData: TDateTime; POra, PVerso, PRilevatore, PCausale: String);
begin
  FOperazioneTimbratura:=POperazione;

  FDatiTimb.Clear;
  FDatiTimb.Progressivo:=PProgressivo;
  FDatiTimb.Data:=PData;

  case FOperazioneTimbratura of
    Nuova:
    begin
      //imposta alcuni dati per la richiesta di timbratura
      FDatiTimb.Operazione:='I';
      FDatiTimb.Ora:='';
      FDatiTimb.Verso:='E';
      FDatiTimb.VersoOrig:='';
      FDatiTimb.Causale:='';
      FDatiTimb.CausaleOrig:='';
      FDatiTimb.Rilevatore:='';
      FDatiTimb.RilevatoreOrig:='';
    end;
    Modifica:
    begin
      // imposta dati per la richiesta di timbratura
      FDatiTimb.Operazione:='M';
      FDatiTimb.Ora:=POra;
      FDatiTimb.Verso:=PVerso;
      FDatiTimb.VersoOrig:=PVerso;
      FDatiTimb.Causale:=PCausale;
      FDatiTimb.CausaleOrig:=PCausale;
      FDatiTimb.Rilevatore:=PRilevatore;
      FDatiTimb.RilevatoreOrig:=PRilevatore;
    end;
    Elimina:
    begin
      FDatiTimb.Operazione:='C';
      FDatiTimb.Ora:=POra;
      FDatiTimb.Verso:=PVerso;
      FDatiTimb.Causale:=PCausale;
      FDatiTimb.RilevatoreOrig:=PRilevatore;
      FDatiTimb.NoteIns:='';
      FDatiTimb.Motivazione:='';
    end;
  end;
end;

function TWM014FRicTimbratureMW.GetCausaliTimbraturaRichiedibiliSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PResultList: TList<TPair<String, String>>): TResCtrl;
var LDataSet: TFDMemTable;
begin
  try
    try
      LDataSet:=TFDMemTable.Create(nil);
      Result:=B110.GetTabellaDizionarioSRV(InfoClient, ParametriLogin, LDataSet,B110_DIZ_TAB_T275_RICHIEDIBILI,'',True);

      if Result.Ok then
      begin
        if Assigned(PResultList) then
          FreeAndNil(PResultList);

        PResultList:=B110.GetListaKeyValue(LDataSet, 'CODICE', 'DESCRIZIONE');
      end;
    finally
      FreeAndNil(LDataSet);
    end;
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

function TWM014FRicTimbratureMW.GetRilevatoriRichiedibiliSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PResultList: TList<TPair<String, String>>): TResCtrl;
var LDataSet: TFDMemTable;
begin
  try
    try
      LDataSet:=TFDMemTable.Create(nil);
      Result:=B110.GetTabellaDizionarioSRV(InfoClient, ParametriLogin, LDataSet, B110_DIZ_TAB_T361, '', True);

      if Result.Ok then
      begin
        if Assigned(PResultList) then
          FreeAndNil(PResultList);

        PResultList:=B110.GetListaKeyValue(LDataSet, 'CODICE', 'DESCRIZIONE');
      end;
    finally
      FreeAndNil(LDataSet);
    end;
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

function TWM014FRicTimbratureMW.GetMotivazioniTimbraturaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PResultList: TList<TPair<String, String>>; var PDefaultCode: String): TResCtrl;
var LDataSet: TFDMemTable;
begin
  try
    try
      LDataSet:=TFDMemTable.Create(nil);
      Result:=B110.GetTabellaDizionarioSRV(InfoClient, ParametriLogin, LDataSet, B110_DIZ_TAB_T106, 'T', False);

      if Result.Ok then
      begin
        if Assigned(PResultList) then
          FreeAndNil(PResultList);

        PResultList:=B110.GetListaKeyValue(LDataSet, 'CODICE', 'DESCRIZIONE');
        PDefaultCode:=VarToStr(B110.GetDefaultCode(LDataSet, 'CODICE_DEFAULT', 'CODICE'));
      end;
    finally
      FreeAndNil(LDataSet);
    end;
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

function TWM014FRicTimbratureMW.GetRilevatoriSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PResultList: TList<TPair<String, String>>): TResCtrl;
var LDataSet: TFDMemTable;
begin
  try
    try
      LDataSet:=TFDMemTable.Create(nil);
      Result:=B110.GetTabellaDizionarioSRV(InfoClient, ParametriLogin, LDataSet, B110_DIZ_TAB_T361, '', False);

      if Result.Ok then
      begin
        if Assigned(PResultList) then
          FreeAndNil(PResultList);

        PResultList:=B110.GetListaKeyValue(LDataSet, 'CODICE', 'DESCRIZIONE');
      end;
    finally
      FreeAndNil(LDataSet);
    end;
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

function TWM014FRicTimbratureMW.GetCausaliTimbraturaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PResultList: TList<TPair<String, String>>): TResCtrl;
var LDataSet: TFDMemTable;
begin
  try
    try
      LDataSet:=TFDMemTable.Create(nil);
      Result:=B110.GetTabellaDizionarioSRV(InfoClient, ParametriLogin, LDataSet, B110_DIZ_TAB_T275,'',False);

      if Result.Ok then
      begin
        if Assigned(PResultList) then
          FreeAndNil(PResultList);

        PResultList:=B110.GetListaKeyValue(LDataSet, 'CODICE', 'DESCRIZIONE');
      end;
    finally
      FreeAndNil(LDataSet);
    end;
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

// TIMBRATURA
//--------------------------------------------------------------------------------------------------------------
function TWM014FRicTimbratureMW.GetTimbratura: String;
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

function TWM014FRicTimbratureMW.GetTimbraturaOrig: String;
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

function TWM014FRicTimbratureMW.GetOperazione: String;
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

function TWM014FRicTimbratureMW.GetOperazioneEstesa: String;
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

end.
