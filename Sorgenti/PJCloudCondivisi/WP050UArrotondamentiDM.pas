unit WP050UArrotondamentiDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IWApplication,
  Dialogs, WR303UGestMasterDetailDM, DB, OracleData, DBClient, WR302UGestTabellaDM, A000UMessaggi,
  A000UInterfaccia, C180FunzioniGenerali, WR102UGestTabella, P050UArrotondamentiMW, WR203UGestDetailFM;

type
  TWP050FArrotondamentiDM = class(TWR303FGestMasterDetailDM)
    selTabellaCOD_ARROTONDAMENTO: TStringField;
    selTabellaCOD_VALUTA: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaTIPO: TStringField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaVALORE: TFloatField;
    selP050K: TOracleDataSet;
    dsrP050K: TDataSource;
    selP050KCOD_ARROTONDAMENTO: TStringField;
    selTabellaDES_VALUTA: TStringField;
    selTabellaD_TIPO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet);Override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure selP050KAfterScroll(DataSet: TDataSet);
    procedure selP050KBeforeDelete(DataSet: TDataSet);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
  private
  public
    P050FArrotondamentiMW: TP050FArrotondamentiMW;
  protected
    procedure RelazionaTabelleFiglie; override;
  end;

implementation

uses WP050UArrotondamentiDettFM, WP050UArrotondamenti,
  WP050UCodArrotondamentoFM;

{$R *.dfm}

procedure TWP050FArrotondamentiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY COD_ARROTONDAMENTO, COD_VALUTA, DECORRENZA');
  selP050K.SetVariable('ORDERBY','ORDER BY COD_ARROTONDAMENTO');
  NonAprireSelTabella:=True;
  inherited;
  P050FArrotondamentiMW:=TP050FArrotondamentiMW.Create(Self);
  P050FArrotondamentiMW.Q050:=selTabella;
  P050FArrotondamentiMW.Q050K:=selP050K;
  selP050K.Open;
  selTabella.Open;
end;

procedure TWP050FArrotondamentiDM.OnNewRecord(DataSet: TDataSet);
begin
  P050FArrotondamentiMW.OnNewRecord;
  inherited;
end;

procedure TWP050FArrotondamentiDM.selP050KAfterScroll(DataSet: TDataSet);
begin
  inherited;
  P050FArrotondamentiMW.P050KAfterScroll;
  if (Self.Owner as TWP050FArrotondamenti).WR302DM <> nil then
    (Self.Owner as TWP050FArrotondamenti).actAggiornaExecute(nil);
end;

procedure TWP050FArrotondamentiDM.selP050KBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  P050FArrotondamentiMW.P050KBeforeDelete;
end;

procedure TWP050FArrotondamentiDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  P050FArrotondamentiMW.CalcFields;
end;

procedure TWP050FArrotondamentiDM.RelazionaTabelleFiglie;
begin
  //Non è stata implementata perchè in questo progetto master e detail SONO invertiti
end;

procedure TWP050FArrotondamentiDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  //Dopo aver cancellato i dettagli c'è un trigger sulla tabella che cancella automaticamente la testata
  //per questo motivo richiamo il refresh della testata
  ((Self.Owner as TWP050FArrotondamenti).DetailFM[0] as TWP050FCodArrotondamentoFM).actAggiornaExecute(nil);
end;

procedure TWP050FArrotondamentiDM.BeforePost(DataSet: TDataSet);
begin
  inherited;
  P050FArrotondamentiMW.BeforePost;
end;

end.
