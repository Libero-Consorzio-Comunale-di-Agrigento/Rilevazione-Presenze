unit B100UWSMedpRepositaryDM;

interface

uses
  SysUtils, Classes, DSServer,
  DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} DBXPlatform, Oracle, OracleData, B021UUtils,
  A000Versione, A000UCostanti, A000USessione,
  C180FunzioniGenerali, DB, Generics.Collections;

type

  TInfoLog = class
  public
    SIW: TSessioneIrisWIN;
    ClassNameServizio: String;
    Operazione: String;
    Parametri: TDictionary<String,String>;
    constructor Create;
    destructor Destroy; override;
    function LogAccesso: Boolean;
  end;

{$METHODINFO ON}
  TB100FWSMedpRepositaryDM = class(TDataModule)
    SessioneMEDP: TOracleSession;
    procedure DataModuleCreate(Sender: TObject);
  private
    //function  Connessione(PParDatabase,PParAzienda,PParUtenteI070:String):TSessioneIrisWIN;
    procedure Log(const PNomeProc, PLogInfo: String); overload; inline;
    procedure Log(const PLogInfo: String); overload; inline;
  public
    LogAttivo: Boolean;
    // ####################   M E T O D I   D I   T E S T   ####################
    function EchoString(PParValue: String): String;
    function updateEchoString(PParId: String; PParJsonObj: TJSONObject): String;
    // ####################   M E T O D I   E F F E T T I V I   ####################
    function GetWS(PIDAzienda:String): TJSONObject;
  end;
{$METHODINFO OFF}

implementation

{$R *.dfm}

uses B100UR010WsEntiDM;

procedure TB100FWSMedpRepositaryDM.DataModuleCreate(Sender: TObject);
const
  NOME_PROC = 'DataModuleCreate';
begin
  LogAttivo:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B100','FILE_LOG','N') = 'S';

  Log(StringOfChar('-',80));
  Log(NOME_PROC,Format('creazione datamodule',[]));

  try
    SessioneMEDP.Connected:=True;
    Log(NOME_PROC,Format('connessione a %s@%s stabilita',[SessioneMEDP.LogonUsername,SessioneMEDP.LogonDatabase]));
  except
    Log(NOME_PROC,Format('connessione a %s@%s FALLITA',[SessioneMEDP.LogonUsername,SessioneMEDP.LogonDatabase]));
    exit;
  end;

  SessionPool.PoolType:=ptDefault;
end;

procedure TB100FWSMedpRepositaryDM.Log(const PNomeProc: String; const PLogInfo: String);
// se LogAttivo traccia sul file di log definito in B021UUtils l'operazione indicata
begin
  if LogAttivo then
    Log(GetLogFmt(Self.ClassName,PNomeProc,PLogInfo));
end;

procedure TB100FWSMedpRepositaryDM.Log(const PLogInfo: String);
// se LogAttivo traccia sul file di log definito in B021UUtils le informazioni indicate
begin
  if LogAttivo then
    R180ScriviMsgLog(FILE_LOG,PLogInfo);
end;

// ******************************************************************* //
// **************   M E T O D I   E S P O R T A T I   **************** //
// ******************************************************************* //

function TB100FWSMedpRepositaryDM.EchoString(PParValue: string): string;
begin
  Result:=PParValue;
end;

function TB100FWSMedpRepositaryDM.updateEchoString(PParId: String; PParJsonObj: TJSONObject):String;
begin
  if PParId = 'chiave' then
    Result:='ciao padrone'
  else
    Result:=PParJsonObj.Get(0).JsonValue.Value;
end;

function TB100FWSMedpRepositaryDM.GetWS(PIDAzienda:String): TJSONObject;
var
  SIW:TSessioneIrisWIN;
  DM: TB100FR010WsEntiDM;
  LInfoLog: TInfoLog;
begin
  // connessione
  SIW:=nil;//Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=SIW;
    LInfoLog.ClassNameServizio:=TB100FR010WsEntiDM.ClassName;
    LInfoLog.Operazione:=OPER_READ;
    LInfoLog.Parametri.Add(B100UR010WsEntiDM.PAR_ID_AZIENDA,PIDAzienda);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;
  // elaborazione
  try
    DM:=TB100FR010WsEntiDM.Create(Self,
                                  GetDatiConnessioneEffettivi('DATABASE','AZIENDA','UTENTE'),
                                  OPER_READ,
                                  LogAttivo);
    try
      DM.SetParam(B100UR010WsEntiDM.PAR_ID_AZIENDA,PIDAzienda);
      DM.ConnessoDB:=True;
      try
        if not SessioneMEDP.Connected then
          SessioneMEDP.LogOn
        else
          SessioneMEDP.CheckConnection(True);
        DM.SessioneMEDP:=SessioneMEDP;
      except
        on E:Exception do
        begin
          DM.ConnessoDB:=False;
          //Log?
          raise;
        end;
      end;
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
  end;
end;

{ TInfoLog }

constructor TInfoLog.Create;
begin
  Parametri:=TDictionary<String,String>.Create;
end;

destructor TInfoLog.Destroy;
begin
  FreeAndNil(Parametri);
  inherited;
end;

function TInfoLog.LogAccesso: Boolean;
// effettua il log di accesso del servizio richiamato su I000 / I001
(*
var
  LRegLog: TRegistraLog;
  LNomeServizio, LNomePar: String;
*)
begin
  (*
  Result:=False;
  if SIW <> nil then
  begin
    try
      LRegLog:=(SIW.RegistraLog as TRegistraLog);
      if LRegLog <> nil then
      begin
        LNomeServizio:=ClassNameServizio.Substring(6,ClassNameServizio.Length - 8);

        LRegLog.SettaProprieta('A','','B100',nil,True);
        LRegLog.InserisciDato('NOME_SERVIZIO','',LNomeServizio);
        LRegLog.InserisciDato('OPERAZIONE','',Operazione);
        LRegLog.InserisciDato('OPERATORE','',SIW.Parametri.Operatore);
        for LNomePar in Parametri.Keys do
          LRegLog.InserisciDato(LNomePar.ToUpper,'',Parametri[LNomePar]);
        LRegLog.RegistraOperazione;
        LRegLog.Session.Commit;
        Result:=True;
      end;
    except
      on E: Exception do
        R180ScriviMsgLog(FILE_LOG,GetLogFmt(Self.ClassName,'LogAccesso',Format('errore log I000: %s',[E.Message])));
    end;
  end;
  *)
end;

end.
