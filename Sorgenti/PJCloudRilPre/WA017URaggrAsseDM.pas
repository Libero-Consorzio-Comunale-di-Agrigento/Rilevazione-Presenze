unit WA017URaggrAsseDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient, A000UCostanti, A000USessione;

type
  TWA017FRaggrAsseDM = class(TWR302FGestTabellaDM)
    selT260: TOracleDataSet;
    dsrT260: TDataSource;
    selTabellaCodice: TStringField;
    selTabellaDescrizione: TStringField;
    selTabellaCodInterno: TStringField;
    selTabellaContASolare: TStringField;
    selTabellaResiduabile: TStringField;
    selTabellaMAXRESIDUO: TStringField;
    selTabellaRAGGRUPPAMENTO_RESIDUO: TStringField;
    selTabellaRAGGR_RESIDUO_PREC: TStringField;
    selTabellaCUMULA_RAGGR_BASE: TStringField;
    selTipiResiduiAC: TOracleDataSet;
    selTabellaMAXRESIDUO_CORR: TStringField;
    selTabellaMAXRESIDUO_PREC: TStringField;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure IWUserSessionBaseCreate(Sender: TObject);
  private
    VecchioCodiceDizionario:String;
  public
  end;

implementation

uses  WA017URaggrAsseDettFM, WA017URaggrAsse;

{$R *.dfm}

procedure TWA017FRaggrAsseDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  inherited;
  selT260.Open;
  selTipiResiduiAC.Open;
end;

procedure TWA017FRaggrAsseDM.AfterPost(DataSet: TDataSet);
var
  S:String;
begin
  with selTabella do
  begin
    S:=FieldByName('CODICE').AsString;
    A000AggiornaFiltroDizionario('RAGGRUPPAMENTI ASSENZA',VecchioCodiceDizionario,S);
    DisableControls;
    Refresh;
    EnableControls;
    Locate('Codice',S,[]);
  end;

  inherited;
  selT260.Refresh;
end;

procedure TWA017FRaggrAsseDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A000AggiornaFiltroDizionario('RAGGRUPPAMENTI ASSENZA',DataSet.FieldByName('CODICE').AsString,'');
end;

procedure TWA017FRaggrAsseDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  if DataSet.State = dsEdit then
    VecchioCodiceDizionario:=VarToStr(DataSet.FieldByName('CODICE').medpOldValue)
  else
    VecchioCodiceDizionario:='';
end;

procedure TWA017FRaggrAsseDM.selTabellaFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept:=A000FiltroDizionario('RAGGRUPPAMENTI ASSENZA',DataSet.FieldByName('CODICE').AsString);
end;

end.
