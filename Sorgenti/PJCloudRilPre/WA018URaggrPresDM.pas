unit WA018URaggrPresDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient,
  A000UCostanti, A000USessione;

type
  TWA018FRaggrPresDM = class(TWR302FGestTabellaDM)
    selTabellaCodice: TStringField;
    selTabellaDescrizione: TStringField;
    selTabellaCodInterno: TStringField;
    selTabellaIndNotturna: TStringField;
    selTabellaIndFestiva: TStringField;
    selTabellaINDPRESENZA: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    VecchioCodiceDizionario:String;
  public
  end;

implementation

{$R *.dfm}

procedure TWA018FRaggrPresDM.AfterPost(DataSet: TDataSet);
var S:String;
begin
  inherited;
  with DataSet do
  begin
    S:=FieldByName('CODICE').AsString;
    A000AggiornaFiltroDizionario('RAGGRUPPAMENTI PRESENZA',VecchioCodiceDizionario,S);
    DisableControls;
    Refresh;
    Locate('CODICE',S,[]);
    EnableControls;
  end;
end;

procedure TWA018FRaggrPresDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A000AggiornaFiltroDizionario('RAGGRUPPAMENTI PRESENZA',DataSet.FieldByName('CODICE').AsString,'');
end;

procedure TWA018FRaggrPresDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
   if DataSet.State = dsEdit then
    VecchioCodiceDizionario:=VarToStr(DataSet.FieldByName('CODICE').medpOldValue)
  else
    VecchioCodiceDizionario:='';
end;

procedure TWA018FRaggrPresDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  inherited;
end;

procedure TWA018FRaggrPresDM.selTabellaFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('RAGGRUPPAMENTI PRESENZA',DataSet.FieldByName('CODICE').AsString);
end;

end.
