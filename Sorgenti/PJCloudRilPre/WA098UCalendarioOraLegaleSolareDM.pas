unit WA098UCalendarioOraLegaleSolareDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  Datasnap.DBClient, A098UCalendarioOraLegSolMW;

type
  TWA098FCalendarioOralegaleSolareDM = class(TWR302FGestTabellaDM)
    cDtsT110: TClientDataSet;
    cDtsT110TORA_COD: TStringField;
    cDtsT110TORA_DESC: TStringField;
    selTabellaVERSO: TStringField;
    selTabellaORAVECCHIA: TStringField;
    selTabellaORANUOVA: TStringField;
    selTabellaTOraDesc: TStringField;
    selTabellaDATA: TDateTimeField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    { Public declarations }
    A098MW: TA098FCalendarioOraLegSolMW;
  end;

implementation

{$R *.dfm}

procedure TWA098FCalendarioOralegaleSolareDM.BeforePostNoStorico(
  DataSet: TDataSet);
begin
  inherited;
  //Controlli pre inserimento
  A098MW.CtrlMax2CambiOraAnno(selTabella.RowId, selTabella.FieldByName('DATA').AsDateTime);
  A098MW.CtrlMax1CambioVersoOra(selTabella.RowId, selTabella.FieldByName('DATA').AsDateTime,
                                selTabella.FieldByName('VERSO').AsString);
  //Assegnazione orari
  if selTabella.FieldByName('VERSO').AsString = 'SL' then
  begin
    selTabella.FieldByName('ORAVECCHIA').AsString:=A098UCalendarioOraLegSolMW.ORASOLARE;
    selTabella.FieldByName('ORANUOVA').AsString:=A098UCalendarioOraLegSolMW.ORALEGALE;
  end
  else if selTabella.FieldByName('VERSO').AsString = 'LS' then
  begin
    selTabella.FieldByName('ORAVECCHIA').AsString:=A098UCalendarioOraLegSolMW.ORALEGALE;
    selTabella.FieldByName('ORANUOVA').AsString:=A098UCalendarioOraLegSolMW.ORASOLARE;
  end;
end;

procedure TWA098FCalendarioOralegaleSolareDM.IWUserSessionBaseCreate(
  Sender: TObject);
begin
  A098MW:=TA098FCalendarioOraLegSolMW.Create(Self);
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

  selTabella.SetVariable('ORDERBY','order by T110.DATA desc');
  inherited;
end;

end.
