unit USelAziendeBase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, Oracle, Variants, StrUtils, Math, A000UCostanti, A000UInterfaccia;

type
  TSelAziendeBase = class(TOracleDataSet)
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure Apri(Sessione:TOracleSession);
    function GetAziende(Anno:Integer;AziendaOld:String;VisTutte:Boolean = False):String;
    function GetDescAziendaBase(CodAziendaBase:String):String;
    function VisualizzaAziende:Boolean;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TSelAziendeBase]);
end;

constructor TSelAziendeBase.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  SQL.Clear;
  SQL.Add('SELECT CODICE, DESCRIZIONE');
  SQL.Add('FROM (SELECT :T440AZIENDA_TUTTE CODICE, ''Tutte le aziende'' DESCRIZIONE');
  SQL.Add('      FROM   DUAL');
  SQL.Add('      WHERE  :VIS_TUTTE = ''S''');
  SQL.Add('      UNION');
  SQL.Add('      SELECT CODICE, :DESCRIZIONE_BASE DESCRIZIONE');
  SQL.Add('      FROM   T440_AZIENDE_BASE');
  SQL.Add('      WHERE  CODICE = :T440AZIENDA_BASE');
  SQL.Add('      UNION');
  SQL.Add('      SELECT T440.CODICE, T440.DESCRIZIONE');
  SQL.Add('      FROM   T440_AZIENDE_BASE T440,');
  SQL.Add('             P500_CUDSETUP P500');
  SQL.Add('      WHERE  T440.CODICE = P500.COD_AZIENDA_BASE');
  SQL.Add('      AND    P500.ANNO = :ANNO');
  SQL.Add('      AND    T440.CODICE <> :T440AZIENDA_BASE)');
  SQL.Add('ORDER BY DECODE(CODICE,:T440AZIENDA_TUTTE,0,:T440AZIENDA_BASE,1,2), CODICE');
  DeclareVariable('T440AZIENDA_BASE',otString);
  DeclareVariable('DESCRIZIONE_BASE',otString);
  DeclareVariable('ANNO',otInteger);
  DeclareVariable('VIS_TUTTE',otString);
  DeclareVariable('T440AZIENDA_TUTTE',otString);
  SetVariable('T440AZIENDA_BASE',T440AZIENDA_BASE);
  SetVariable('DESCRIZIONE_BASE',Parametri.RagioneSociale);
  SetVariable('ANNO',0);
  SetVariable('VIS_TUTTE','S');
  SetVariable('T440AZIENDA_TUTTE',T440AZIENDA_TUTTE);
end;

procedure TSelAziendeBase.Apri(Sessione:TOracleSession);
begin
  Session:=Sessione;
  Open;
end;

function TSelAziendeBase.GetAziende(Anno:Integer;AziendaOld:String;VisTutte:Boolean = False):String;
begin
  Result:=AziendaOld;
  Close;
  SetVariable('ANNO',Anno);
  SetVariable('VIS_TUTTE',IfThen(VisTutte,'S','N'));
  Open;
  FieldByName('CODICE').DisplayWidth:=7;
  FieldByName('DESCRIZIONE').DisplayWidth:=600;
  if VarToStr(Lookup('CODICE',AziendaOld,'CODICE')) <> AziendaOld then
  begin
    if VisTutte then
      Result:=T440AZIENDA_TUTTE//L'azienda T440AZIENDA_TUTTE è disponibile solo su richiesta
    else
      Result:=T440AZIENDA_BASE;//L'azienda T440AZIENDA_BASE è sempre disponibile
  end;
  //Per le elaborazioni che prevedono la possibilità di scegliere Tutte le aziende, per pulizia,
  //se c'è solo l'azienda BASE, forzo il valore * come se non ci fosse la gestione multiazienda
  if (Result = T440AZIENDA_BASE) and not VisualizzaAziende and VisTutte then
    Result:=T440AZIENDA_TUTTE;
end;

function TSelAziendeBase.GetDescAziendaBase(CodAziendaBase:String):String;
begin
  Result:=VarToStr(Lookup('CODICE',CodAziendaBase,'DESCRIZIONE'));
end;

function TSelAziendeBase.VisualizzaAziende:Boolean;
begin
  Result:=RecordCount > IfThen(VarToStr(GetVariable('VIS_TUTTE')) = 'S',2,1);
end;

destructor TSelAziendeBase.Destroy;
begin
  Close;
  inherited Destroy;
end;

end.
