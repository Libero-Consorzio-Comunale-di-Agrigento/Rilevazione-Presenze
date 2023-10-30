unit A098UCalendarioOraLegSolMW;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R005UDataModuleMW, Oracle;

const
  ORASOLARE = '02.00';
  ORALEGALE = '03.00';

type
  TA098FCalendarioOraLegSolMW = class(TR005FDataModuleMW)
    QryControlli: TOracleQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CtrlMax2CambiOraAnno(RowID:string; Data:TDateTime);
    procedure CtrlMax1CambioVersoOra(RowID:string; Data:TDateTime; Verso:string);
  end;

implementation

{$R *.dfm}

procedure TA098FCalendarioOraLegSolMW.CtrlMax2CambiOraAnno(RowID:string; Data:TDateTime);
begin
  QryControlli.DeleteVariables;
  QryControlli.SQL.Clear;
  QryControlli.SQL.Add('begin');
  QryControlli.SQL.Add('  select count(*) into :NUM_REC');
  QryControlli.SQL.Add('    from T110_ORALEGALESOLARE T110');
  QryControlli.SQL.Add('   where trunc(T110.DATA,''YYYY'') = trunc(:DATA,''YYYY'')');
  QryControlli.SQL.Add('     and T110.ROWID <> :ROWID;');
  QryControlli.SQL.Add('end;');
  QryControlli.DeclareAndSet('DATA',otDate,Data);
  QryControlli.DeclareAndSet('ROWID',otString,RowID);
  QryControlli.DeclareVariable('NUM_REC',otInteger);
  QryControlli.Execute;
  if QryControlli.GetVariable('NUM_REC') > 1 then
    raise Exception.Create('Impossibile inserire più di due cambi orario all''anno.');
end;

procedure TA098FCalendarioOraLegSolMW.CtrlMax1CambioVersoOra(RowID:string;Data:TDateTime; Verso:string);
begin
  QryControlli.DeleteVariables;
  QryControlli.SQL.Clear;
  QryControlli.SQL.Add('begin');
  QryControlli.SQL.Add('  select count(*) into :NUM_REC');
  QryControlli.SQL.Add('    from T110_ORALEGALESOLARE T110');
  QryControlli.SQL.Add('   where trunc(T110.DATA,''YYYY'') = trunc(:DATA,''YYYY'')');
  QryControlli.SQL.Add('     and T110.VERSO = :VERSO');
  QryControlli.SQL.Add('     and T110.ROWID <> :ROWID;');
  QryControlli.SQL.Add('end;');
  QryControlli.DeclareAndSet('DATA',otDate,Data);
  QryControlli.DeclareAndSet('VERSO',otString,Verso);
  QryControlli.DeclareAndSet('ROWID',otString,RowID);
  QryControlli.DeclareVariable('NUM_REC',otInteger);
  QryControlli.Execute;
  if QryControlli.GetVariable('NUM_REC') > 0 then
    raise Exception.Create('Impossibile inserire lo stesso cambiamento di orario all''interno dello stesso anno.');
end;

end.
