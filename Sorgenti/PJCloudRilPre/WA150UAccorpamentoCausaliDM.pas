unit WA150UAccorpamentoCausaliDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR303UGestMasterDetailDM, DB, OracleData,
  A000UCostanti, A000UInterfaccia, A000UMessaggi,
  A150UAccorpamentoCausaliMW;

type
  TWA150FAccorpamentoCausaliDM = class(TWR303FGestMasterDetailDM)
    selTabellaCOD_TIPOACCORPCAUSALI: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaTIPO: TStringField;
    selT256: TOracleDataSet;
    selT256COD_TIPOACCORPCAUSALI: TStringField;
    selT256COD_CODICIACCORPCAUSALI: TStringField;
    selT256DESCRIZIONE: TStringField;
    dsrT256: TDataSource;
    selT256D_TIPOACCORPCAUSALI: TStringField;
    selTabellaD_TIPO: TStringField;
    selT257: TOracleDataSet;
    selT257COD_TIPOACCORPCAUSALI: TStringField;
    selT257COD_CODICIACCORPCAUSALI: TStringField;
    selT257COD_CAUSALE: TStringField;
    selT257DECORRENZA: TDateTimeField;
    selT257DECORRENZA_FINE: TDateTimeField;
    selT257DESCRIZIONE: TStringField;
    selT257PERCENTUALE: TFloatField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet);Override;
    procedure BeforeDelete(DataSet: TDataSet);Override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure selT256BeforeInsert(DataSet: TDataSet);
    procedure selT256AfterPost(DataSet: TDataSet);
    procedure selT256AfterScroll(DataSet: TDataSet);
    procedure selT256NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    A150MW: TA150FAccorpamentoCausaliMW;
    const
      D_Tipo:array[0..2] of TItemsValues = (
        (Item:'ALTRO';  Value:'Nessuno'),
        (Item:'WEB';    Value:'Iter autorizzativo assenze(IrisWeb)'),
        (Item:'ASP';    Value:'Aspettative')
        );
  protected
    procedure RelazionaTabelleFiglie; override;
  end;

implementation

uses WA150UAccorpamentoCausali, WA150UCausaliFM;

{$R *.dfm}

procedure TWA150FAccorpamentoCausaliDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  SelTabella.SetVariable('ORDERBY','ORDER BY COD_TIPOACCORPCAUSALI');
  A150MW:=TA150FAccorpamentoCausaliMW.Create(Self);
  selT256.SetVariable('ORDERBY','ORDER BY COD_TIPOACCORPCAUSALI, COD_CODICIACCORPCAUSALI');
  inherited;
  SetTabelleRelazionate([selTabella,selT256]);
end;

procedure TWA150FAccorpamentoCausaliDM.RelazionaTabelleFiglie;
begin
  inherited;
  if InterfacciaWR102.StoricizzazioneInCorso = False then
  begin
    with selT256 do
    begin
      DisableControls;
      Close;
      SetVariable('CodTipoAccorpCausali',SelTabella.FieldByName('COD_TIPOACCORPCAUSALI').AsString);
      Open;
      EnableControls;
      end;
    if (Self.Owner as TWA150FAccorpamentoCausali).WA150CausaliFM <> nil then
      ((Self.Owner as TWA150FAccorpamentoCausali).WA150CausaliFM as TWA150FCausaliFM).AggiornaGridAccorpCausali;
  end;
end;

procedure TWA150FAccorpamentoCausaliDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if A150MW.Q257.RecordCount > 0 then
    raise exception.Create(A000MSG_A150_ERR_CANC_ACCORPAMENTO);
end;

procedure TWA150FAccorpamentoCausaliDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A150MW.VerificaAccorpamentoWeb(DataSet);
end;

procedure TWA150FAccorpamentoCausaliDM.selT256AfterPost(DataSet: TDataSet);
begin
  SelT256.FieldByName('COD_CODICIACCORPCAUSALI').ReadOnly:=True;
end;

procedure TWA150FAccorpamentoCausaliDM.selT256AfterScroll(DataSet: TDataSet);
begin
  A150MW.RefreshQ257(selT256.FieldByName('COD_TIPOACCORPCAUSALI').AsString,selT256.FieldByName('COD_CODICIACCORPCAUSALI').AsString);
  if (Self.Owner as TWA150FAccorpamentoCausali).WA150CausaliFM <> nil then
      ((Self.Owner as TWA150FAccorpamentoCausali).WA150CausaliFM as TWA150FCausaliFM).AggiornaGridAccorpCausali;
end;

procedure TWA150FAccorpamentoCausaliDM.selT256BeforeInsert(DataSet: TDataSet);
begin
  SelT256.FieldByName('COD_CODICIACCORPCAUSALI').ReadOnly:=False;
end;

procedure TWA150FAccorpamentoCausaliDM.selT256NewRecord(DataSet: TDataSet);
begin
  // Verifico perchè secondo me dovrebbe già essere settato in automatico il field
  SelT256.FieldByName('COD_TIPOACCORPCAUSALI').AsString:=SelTabella.FieldByName('COD_TIPOACCORPCAUSALI').AsString;
end;

procedure TWA150FAccorpamentoCausaliDM.selTabellaCalcFields(DataSet: TDataSet);
var i: Integer;
begin
  inherited;
  for i:=0 to High(D_Tipo) do
    if D_Tipo[i].Item = selTabella.FieldByName('TIPO').AsString then
      selTabella.FieldByName('D_TIPO').AsString:=D_Tipo[i].Value;
end;

end.
