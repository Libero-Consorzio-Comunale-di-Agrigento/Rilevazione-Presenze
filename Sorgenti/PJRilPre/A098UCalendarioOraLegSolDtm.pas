unit A098UCalendarioOraLegSolDtm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R004UGestStoricoDTM, A098UCalendarioOraLegSolMW,
  Data.DB, OracleData, C180FunzioniGenerali, Datasnap.DBClient, Oracle;

type
  TA098FCalendarioOraLegSolDtm = class(TR004FGestStoricoDtM)
    selT110: TOracleDataSet;
    selT110ORAVECCHIA: TStringField;
    selT110ORANUOVA: TStringField;
    selT110DATA: TDateTimeField;
    cDtsT110: TClientDataSet;
    cDtsT110TORA_COD: TStringField;
    selT110VERSO: TStringField;
    selT110TOraDesc: TStringField;
    cDtsT110TORA_DESC: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT110BeforePost(DataSet: TDataSet);
    procedure selT110NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    A098MW:TA098FCalendarioOraLegSolMW;
  public
    { Public declarations }
  end;

var
  A098FCalendarioOraLegSolDtm: TA098FCalendarioOraLegSolDtm;

implementation

{$R *.dfm}

procedure TA098FCalendarioOraLegSolDtm.DataModuleCreate(Sender: TObject);
begin
  inherited;
  cDtsT110.CreateDataSet;
  cDtsT110.Open;
  cDtsT110.Insert;
  cDtsT110.FieldByName('TORA_COD').AsString:='LS';
  cDtsT110.FieldByName('TORA_DESC').AsString:='Legale - Solare';
  cDtsT110.Post;

  cDtsT110.Insert;
  cDtsT110.FieldByName('TORA_COD').AsString:='SL';
  cDtsT110.FieldByName('TORA_DESC').AsString:='Solare - Legale';
  cDtsT110.Post;

  InizializzaDataSet(selT110, []);
  selT110.Open;
  A098MW:=TA098FCalendarioOraLegSolMW.Create(nil);
end;

procedure TA098FCalendarioOraLegSolDtm.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A098MW);
end;

procedure TA098FCalendarioOraLegSolDtm.selT110BeforePost(DataSet: TDataSet);
begin
  inherited;
  //Controlli pre inserimento
  A098MW.CtrlMax2CambiOraAnno(selT110.RowId, selT110.FieldByName('DATA').AsDateTime);
  A098MW.CtrlMax1CambioVersoOra(selT110.RowId, selT110.FieldByName('DATA').AsDateTime,
                                selT110.FieldByName('VERSO').AsString);
  //Assegnazione orari
  if selT110.FieldByName('VERSO').AsString = 'SL' then
  begin
    selT110.FieldByName('ORAVECCHIA').AsString:=A098UCalendarioOraLegSolMW.ORASOLARE;
    selT110.FieldByName('ORANUOVA').AsString:=A098UCalendarioOraLegSolMW.ORALEGALE;
  end
  else if selT110.FieldByName('VERSO').AsString = 'LS' then
  begin
    selT110.FieldByName('ORAVECCHIA').AsString:=A098UCalendarioOraLegSolMW.ORALEGALE;
    selT110.FieldByName('ORANUOVA').AsString:=A098UCalendarioOraLegSolMW.ORASOLARE;
  end;
end;

procedure TA098FCalendarioOraLegSolDtm.selT110NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT110.FieldByName('DATA').AsDateTime:=Date;
end;

end.
