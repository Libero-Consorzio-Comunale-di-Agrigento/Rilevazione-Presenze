unit R005UDataModuleMW;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  C004UParamForm,
  SysUtils,
  Classes,
  DB,
  Oracle,
  OracleData;

type
  // tipi proc. generiche
  TprocString = procedure(S: String) of object;
  TprocInteger = procedure(i: Integer) of object;
  TprocNone = procedure of object;
  TprocObject = procedure(Sender: TObject) of object;
  // tipi proc. per eventi dataset
  TAfterOpen = procedure(DataSet: TDataSet) of object;
  TAfterPost = procedure(DataSet: TDataSet) of object;
  TAfterRefresh = procedure(DataSet: TDataSet) of object;
  TAfterScroll = procedure(DataSet: TDataSet) of object;
  TBeforeDelete = procedure(DataSet: TDataSet) of object;
  TBeforeEdit = procedure(DataSet: TDataSet) of object;
  TBeforeInsert = procedure(DataSet: TDataSet) of object;
  TBeforePost = procedure(DataSet: TDataSet) of object;
  TOnCalcFields = procedure(DataSet: TDataSet) of object;
  TOnFilterRecord = procedure(DataSet: TDataSet; var Accept: Boolean) of object;
  TOnPostError = procedure(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction) of object;

  TmedpFieldHelper = class helper for TField
  public
    function medpOldValue: Variant;
  end;

  TR005FDataModuleMW = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    NomeOwner: string;
    SessioneOracleR005: TOracleSession;
    function ProgressivoC700:Integer;
    function GetNomeOwner: String;
  public
    SelAnagrafe: TOracleDataSet;
    C004DM_MW: TC004FParamForm;
    ScriviStatusBar:TprocString;
    ResettaProgressBar:TprocNone;
    IncrementaProgressBar:TprocNone;
    MaxProgressBar:TprocInteger;
    // tipo modulo chiamante
    TipoModulo: string;
    // documento pdf
    DocumentoPDF: string;
    // codice form per registrazione log e altre attività
    CodForm: string;
    procedure SetSessioneOracle(POracleSession: TOracleSession);
  end;

implementation

{$R *.dfm}

{ TmedpFieldHelper }
function TmedpFieldHelper.medpOldValue: Variant;
begin
  Result:=Self.OldValue;
  if Self.DataSet.State = dsInsert then
    raise Exception.Create('medpOldValue non accessibile!' + #13#10 + 'Notificare al servizio di assistenza del software.');
end;

procedure TR005FDataModuleMW.DataModuleCreate(Sender: TObject);
begin
  inherited;

  // imposta la sessione oracle a tutti gli oggetti TOracleXXX contenuti
  if (Owner <> nil) and (Owner is TOracleSession) then
    SessioneOracleR005:=(Owner as TOracleSession)
  (*else if (Owner <> nil) and (Owner is TSessioneIrisWIN) then
    SessioneOracleR005:=(Owner as TSessioneIrisWIN).SessioneOracle*)
  else
    SessioneOracleR005:=SessioneOracle;
  SetSessioneOracle(SessioneOracleR005);

  // imposta il nome dell'owner
  NomeOwner:=GetNomeOwner;

  // il tipo modulo di default è client/server
  TipoModulo:=TTipoModuloRec.ClientServer;

  // inizializza il nome del documento pdf
  DocumentoPDF:='';
end;

function TR005FDataModuleMW.ProgressivoC700: Integer;
// estrae il progressivo corrente di SelAnagrafe
begin
  if (SelAnagrafe <> nil) and (SelAnagrafe.Active) then
    Result:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger
  else
    Result:=0;
end;

function TR005FDataModuleMW.GetNomeOwner: String;
begin
  Result:='';

  if Owner <> nil then
    Result:=Copy(Owner.Name,1,{$IFNDEF WEBPJ}4{$ELSE}5{$ENDIF});

  //Se Owner valorizzato ma con nome nullo, utilizzo il nome di sè stesso (in IrisCloud è W + nome)
  //es. A112 che deve creare A12MW con owner = SessioneIrisWIN per utilizzo in R110
  if Result = '' then
    Result:={$IFDEF WEBPJ}'W' + {$ENDIF}Copy(Self.Name,1,4);
end;

procedure TR005FDataModuleMW.SetSessioneOracle(POracleSession: TOracleSession);
// assegna la sessione oracle indicata agli oggetti di tipo
// - TOracleDataset
// - TOracleQuery
// - TOracleScript
var
  i: Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleDataSet then
    begin
      // dataset: assegna sessione oracle
      if (Components[i] as TOracleDataSet).Session = nil then
        (Components[i] as TOracleDataSet).Session:=POracleSession;
    end
    else if Components[i] is TOracleQuery then
    begin
      // oracle query
      // assegna sessione oracle
      if (Components[i] as TOracleQuery).Session = nil then
        (Components[i] as TOracleQuery).Session:=POracleSession;
    end
    else if Components[i] is TOracleScript then
    begin
      // oracle script
      // assegna sessione oracle
      if (Components[i] as TOracleScript).Session = nil then
        (Components[i] as TOracleScript).Session:=POracleSession;
    end;
  end;
end;

end.
