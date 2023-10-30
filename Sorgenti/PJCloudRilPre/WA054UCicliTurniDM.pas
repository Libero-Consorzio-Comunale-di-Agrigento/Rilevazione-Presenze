unit WA054UCicliTurniDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, Data.DB,
  OracleData, A054UCicliTurniMW, A000UInterfaccia;

type
  TWA054FCicliTurniDM = class(TWR303FGestMasterDetailDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterCancel(DataSet: TDataSet);override;
    procedure AfterDelete(DataSet: TDataSet);override;
    procedure AfterPost(DataSet: TDataSet);override;
    procedure BeforeDelete(DataSet: TDataSet);override;
    procedure BeforeInsert(DataSet: TDataSet);override;
    procedure BeforePostNoStorico(DataSet: TDataSet);override;
  private
    procedure TrovaMaxGiorno;
    procedure RelazionaTabelleFiglie;override;
  public
    A054MW: TA054FCicliTurniMW;
    MaxGiornoCiclo: Integer;
    procedure RiordinaGiorni;
  end;

implementation

{$R *.dfm}

procedure TWA054FCicliTurniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  A054MW:=TA054FCicliTurniMW.Create(Self);
  A054MW.Q610:=selTabella;
  inherited;
end;

procedure TWA054FCicliTurniDM.RelazionaTabelleFiglie;
begin
  inherited;
  with A054MW do
  begin
    Q611.DisableControls;
    Q611.Close;
    Q611.SetVariable('CICLO',selTabella.FieldByName('CODICE').AsString);
    Q611.Open;
    TrovaMaxGiorno;
    Q611.EnableControls;
  end;
end;

procedure TWA054FCicliTurniDM.TrovaMaxGiorno;
begin
  MaxGiornoCiclo:=0;
  with A054MW.Q611 do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('Giorno').AsInteger > MaxGiornoCiclo then
        MaxGiornoCiclo:=FieldByName('Giorno').AsInteger;
      Next;
    end;
  end;
end;

procedure TWA054FCicliTurniDM.AfterCancel(DataSet: TDataSet);
begin
  inherited;
  SelTabella.CancelUpdates;
end;

procedure TWA054FCicliTurniDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  try
    SessioneOracle.ApplyUpdates([SelTabella],True);
  except
    SessioneOracle.Rollback;
    raise;
  end;
end;

procedure TWA054FCicliTurniDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  try
    SessioneOracle.ApplyUpdates([SelTabella],True);
  except
    SessioneOracle.Rollback;
    raise;
  end;
end;

procedure TWA054FCicliTurniDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A054MW.BeforeDelete;
end;

procedure TWA054FCicliTurniDM.BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  A054MW.BeforeInsert;
end;

procedure TWA054FCicliTurniDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A054MW.BeforePost;
end;

procedure TWA054FCicliTurniDM.RiordinaGiorni;
begin
  if A054MW.Q611.State in [dsEdit,dsInsert] then
    A054MW.Q611.Post;
  try
    A054MW.SettaGiornoProgressivo(1000);
    SessioneOracle.ApplyUpdates([A054MW.Q611],True);
    A054MW.SettaGiornoProgressivo(0);
    SessioneOracle.ApplyUpdates([A054MW.Q611],True);
    SessioneOracle.Commit;
    RegistraLog.SettaProprieta('M','T611_CICLIGIORNALIERI',Copy(Name,1,5),nil,True);
    RegistraLog.InserisciDato('CODICE',A054MW.Q611Ciclo.AsString,'');
    RegistraLog.RegistraOperazione;
  except
    SessioneOracle.Rollback;
    raise;
  end;
end;

end.
