unit WM000UDataModuleBaseDM;

interface

uses
  System.SysUtils, System.Classes, Oracle, Variants,
  OracleData, A000USessione, RegistrazioneLog;

type
  TWM000FDataModuleBaseDM = class(TDataModule)
  private
    FSessioneIrisWin: TSessioneIrisWin;
    procedure SetSessioneOracle;
    function GetRegistraLog: TRegistraLog;
    function GetRegistraMsg: TRegistraMsg;
    function GetSessioneOracle: TOracleSession;
  protected
    //function TransV430toT430(ODS:TOracleDataset):Boolean;
  public
    property SessioneIrisWin: TSessioneIrisWin read FSessioneIrisWin;
    property SessioneOracle: TOracleSession read GetSessioneOracle;
    property RegistraLog: TRegistraLog read GetRegistraLog;
    property RegistraMsg: TRegistraMsg read GetRegistraMsg;

    constructor Create(PSessioneIrisWin: TSessioneIrisWin); overload;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TWM000FDataModuleBaseDM.Create(PSessioneIrisWin: TSessioneIrisWin);
begin
  inherited Create(nil);

  if Assigned(PSessioneIrisWin) then
  begin
    FSessioneIrisWin:=PSessioneIrisWin;
    SetSessioneOracle;
  end;
end;

function TWM000FDataModuleBaseDM.GetRegistraLog: TRegistraLog;
begin
  if Assigned(FSessioneIrisWin) then
    Result:=(FSessioneIrisWin.RegistraLog as TRegistralog)
  else
    Result:=nil;
end;

function TWM000FDataModuleBaseDM.GetRegistraMsg: TRegistraMsg;
begin
  if Assigned(FSessioneIrisWin) then
    Result:=(FSessioneIrisWin.RegistraMsg as TRegistraMsg)
  else
    Result:=nil;
end;

function TWM000FDataModuleBaseDM.GetSessioneOracle: TOracleSession;
begin
  if Assigned(FSessioneIrisWin) then
    Result:=FSessioneIrisWin.SessioneOracle
  else
    Result:=nil;
end;

procedure TWM000FDataModuleBaseDM.SetSessioneOracle;
// assegna la sessione oracle indicata agli oggetti di tipo
// - TOracleDataset
// - TOracleQuery
// - TOracleScript
var
  i: Integer;
begin
  if Assigned(FSessioneIrisWin) then
    for i:=0 to Self.ComponentCount - 1 do
    begin
      if Components[i] is TOracleDataSet then
      begin
        // dataset: assegna sessione oracle
        if (Components[i] as TOracleDataSet).Session = nil then
          (Components[i] as TOracleDataSet).Session:=FSessioneIrisWin.SessioneOracle;
      end
      else if Components[i] is TOracleQuery then
      begin
        // oracle query
        // assegna sessione oracle
        if (Components[i] as TOracleQuery).Session = nil then
          (Components[i] as TOracleQuery).Session:=FSessioneIrisWin.SessioneOracle;
      end
      else if Components[i] is TOracleScript then
      begin
        // oracle script
        // assegna sessione oracle
        if (Components[i] as TOracleScript).Session = nil then
          (Components[i] as TOracleScript).Session:=FSessioneIrisWin.SessioneOracle;
      end;
    end;
end;

{function TWM000FDataModuleBaseDM.TransV430toT430(ODS:TOracleDataset):Boolean;
var SQL:String;
    i:Integer;

  function EsisteCampoV430Incompatibile(S:String):Boolean;
  // controllo che non esistano campi incompatibili: P430Campo, T430D_Campo
  begin
    Result:=False;
    S:=StringReplace(S,'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)','',[rfReplaceAll,rfIgnoreCase]);
    with cdsI010 do
    try
      Filtered:=False;
      Filter:='((NOME_CAMPO = ''T430D_*'') or (NOME_CAMPO = ''P430*''))';
      Filtered:=True;
      First;
      while not Eof do
      begin
        if Pos(UpperCase(FieldByName('NOME_CAMPO').AsString),UpperCase(S)) > 0 then
        begin
          Result:=True;
          Break;
        end;
        Next;
      end;
    finally
      Filter:='';
      Filtered:=False;
    end;
  end;

  function V430toT430(S:String):String;
  begin
    //Per gestire il caso in cui la V430 contenga anche la join con P430
    S:=StringReplace(S,'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)','',[rfReplaceAll,rfIgnoreCase]);

    Result:=S;
    if Pos('T430',UpperCase(S)) = 0 then
      exit;

    S:=StringReplace(S,'V430_STORICO V430','T430_STORICO T430',[rfReplaceAll,rfIgnoreCase]);
    S:=StringReplace(S,'V430.T430','T430.',[rfReplaceAll,rfIgnoreCase]);
    //Modifica puntuale dei riferimenti ai campi T430campo in T430.campo
    with cdsI010 do
    try
      Filtered:=False;
      Filter:='(NOME_CAMPO = ''T430*'')';
      Filtered:=True;
      First;
      while not Eof do
      begin
        S:=StringReplace(S,FieldByName('NOME_CAMPO').AsString,StringReplace(FieldByName('NOME_CAMPO').AsString,'T430','T430.',[]),[rfReplaceAll,rfIgnoreCase]);
        Next;
      end;
    finally
      Filter:='';
      Filtered:=False;
    end;
    Result:=S;
  end;

begin
  Result:=False;

  //Controllo che non esistano campi incompatibili: P430Campo, T430D_Campo
  if EsisteCampoV430Incompatibile(ODS.SQL.Text) then
    exit;
  for i:=0 to ODS.VariableCount - 1 do
    if ODS.VariableType(i) = otSubst then
      if EsisteCampoV430Incompatibile(VarToStr(ODS.GetVariable(i))) then
        exit;

  Result:=True;
  ODS.SQL.Text:=V430toT430(ODS.SQL.Text);
  for i:=0 to ODS.VariableCount - 1 do
    if ODS.VariableType(i) = otSubst then
    begin
      SQL:=VarToStr(ODS.GetVariable(i));
      ODS.SetVariable(i,V430toT430(SQL));
    end;
end;}

end.
