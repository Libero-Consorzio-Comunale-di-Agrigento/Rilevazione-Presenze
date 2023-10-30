unit WA055UTurnazioniDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, Data.DB,
  OracleData, A055UTurnazioniMW, A000UInterfaccia;

type
  TWA055FTurnazioniDM = class(TWR303FGestMasterDetailDM)
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
    procedure TrovaMaxOrdineTurno;
    procedure RelazionaTabelleFiglie;override;
  public
    A055MW: TA055FTurnazioniMW;
    MaxOrdineTurno: Integer;
    procedure RiordinaGiorni;
  end;


implementation

{$R *.dfm}

procedure TWA055FTurnazioniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  A055MW:=TA055FTurnazioniMW.Create(Self);
  A055MW.Q640:=selTabella;
  inherited;
end;

procedure TWA055FTurnazioniDM.RelazionaTabelleFiglie;
begin
  inherited;
  with A055MW do
  begin
    Q641.DisableControls;
    Q641.Close;
    Q641.SetVariable('TURNAZIONE',selTabella.FieldByName('CODICE').AsString);
    Q641.Open;
    TrovaMaxOrdineTurno;
    Q641.EnableControls;
  end;
end;

procedure TWA055FTurnazioniDM.AfterCancel(DataSet: TDataSet);
begin
  inherited;
  SelTabella.CancelUpdates;
end;

procedure TWA055FTurnazioniDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  try
    SessioneOracle.ApplyUpdates([SelTabella],True);
  except
    SessioneOracle.Rollback;
    raise;
  end;
end;

procedure TWA055FTurnazioniDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  try
    SessioneOracle.ApplyUpdates([SelTabella],True);
  except
    SessioneOracle.Rollback;
    raise;
  end;
end;

procedure TWA055FTurnazioniDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A055MW.BeforeDelete;
end;

procedure TWA055FTurnazioniDM.BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  A055MW.Q641.Close;
end;

procedure TWA055FTurnazioniDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A055MW.BeforePost;
end;

procedure TWA055FTurnazioniDM.RiordinaGiorni;
begin
  if A055MW.Q641.State in [dsEdit,dsInsert] then
    A055MW.Q641.Post;
  try
    A055MW.SettaOrdineProgressivo(1000);
    SessioneOracle.ApplyUpdates([A055MW.Q641],True);
    A055MW.SettaOrdineProgressivo(0);
    SessioneOracle.ApplyUpdates([A055MW.Q641],True);
    SessioneOracle.Commit;
    RegistraLog.SettaProprieta('M','T641_MOLTTURNAZIONE',Copy(Name,1,5),nil,True);
    RegistraLog.InserisciDato('CODICE',A055MW.Q641Turnazione.AsString,'');
    RegistraLog.RegistraOperazione;
  except
    SessioneOracle.Rollback;
    raise;
  end;
end;

procedure TWA055FTurnazioniDM.TrovaMaxOrdineTurno;
begin
  MaxOrdineTurno:=0;
  with A055MW.Q641 do
  begin
    First;
    while not Eof do
    begin
      if(FieldByName('ORDINE').AsInteger > MaxOrdineTurno)then
        MaxOrdineTurno:=FieldByName('ORDINE').AsInteger;
      Next;
    end;
  end;
end;

end.
