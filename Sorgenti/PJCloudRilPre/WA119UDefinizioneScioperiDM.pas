unit WA119UDefinizioneScioperiDM;

interface

uses
  A119UPartecipazioneScioperiMW,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, WR302UGestTabellaDM, Data.DB, OracleData,
  WR205UDettTabellaFM, WR303UGestMasterDetailDM;

type
  TWA119FDefinizioneScioperiDM = class(TWR303FGestMasterDetailDM)
    selTabellaID: TFloatField;
    selTabellaDATA: TDateTimeField;
    selTabellaCAUSALE: TStringField;
    selTabellaTIPOGIUST: TStringField;
    selTabellaDAORE: TStringField;
    selTabellaAORE: TStringField;
    selTabellaSELEZIONE_ANAGRAFICA: TStringField;
    selTabellaGG_NOTIFICA: TIntegerField;
    selTabellaD_GG_NOTIFICA: TStringField;
    selTabellaD_TIPOGIUST: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure dsrTabellaStateChange(Sender: TObject);
    procedure dsrTabellaDataChange(Sender: TObject; Field: TField);
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure BeforeEdit(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure AfterScroll(DataSet: TDataSet); override;
  protected
    procedure RelazionaTabelleFiglie; override;
  public
    A119MW: TA119FPartecipazioneScioperiMW;
  end;

implementation

uses WA119UDefinizioneScioperi, WA119UDefinizioneScioperiDettFM;

{$R *.dfm}

procedure TWA119FDefinizioneScioperiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  A119MW:=TA119FPartecipazioneScioperiMW.Create(Self);
  selTabella.SetVariable('ORDERBY','ORDER BY DATA DESC');
  selTabella.FieldByName('ID').Visible:=DebugHook <> 0;
  inherited;
  A119MW.selT250_Funzioni:=selTabella;
end;

procedure TWA119FDefinizioneScioperiDM.IWUserSessionBaseDestroy(
  Sender: TObject);
begin
  FreeAndNil(A119MW);
  inherited;
end;

procedure TWA119FDefinizioneScioperiDM.dsrTabellaDataChange(Sender: TObject;
  Field: TField);
var
  LDettFM: TWR205FDettTabellaFM;
begin
  LDettFM:=(Self.Owner as TWA119FDefinizioneScioperi).WDettaglioFM;
  if LDettFM <> nil then
  begin
    with (LDettFM as TWA119FDefinizioneScioperiDettFM) do
    begin
      SetDescrizioneCausale;
    end;
  end;
end;

procedure TWA119FDefinizioneScioperiDM.dsrTabellaStateChange(Sender: TObject);
var
  LDettFM: TWR205FDettTabellaFM;
begin
  inherited;
  LDettFM:=(Self.Owner as TWA119FDefinizioneScioperi).WDettaglioFM;
  if LDettFM <> nil then
    (LDettFM as TWA119FDefinizioneScioperiDettFM).OnDsrStateChange;
end;

procedure TWA119FDefinizioneScioperiDM.OnNewRecord(DataSet: TDataSet);
var
  LDettFM: TWR205FDettTabellaFM;
begin
  inherited;
  A119MW.selT250NewRecord(DataSet);
  LDettFM:=(Self.Owner as TWA119FDefinizioneScioperi).WDettaglioFM;
  if LDettFM <> nil then
    (LDettFM as TWA119FDefinizioneScioperiDettFM).OnInserimento;
end;

procedure TWA119FDefinizioneScioperiDM.RelazionaTabelleFiglie;
// relazione tabella figlia
begin
  A119MW.CaricaDettaglioRichiesta(selTabella.FieldByName('ID').AsInteger);
end;

procedure TWA119FDefinizioneScioperiDM.selTabellaCalcFields(DataSet: TDataSet);
var
  DataIniStr, DescGGNotifica: String;
begin
  inherited;
  // descrizione giorni notifica
  with selTabella do
  begin
    DescGGNotifica:='';
    if (not FieldByName('DATA').IsNull) and
       (not FieldByName('GG_NOTIFICA').IsNull) then
    begin
      DataIniStr:=FormatDateTime('dd/mm/yyyy',FieldByName('DATA').AsDateTime - FieldByName('GG_NOTIFICA').AsInteger);
      DescGGNotifica:=Format('(a partire dal %s)',[DataIniStr]);
    end;
    FieldByName('D_GG_NOTIFICA').AsString:=DescGGNotifica;
  end;
end;

procedure TWA119FDefinizioneScioperiDM.AfterScroll(DataSet: TDataSet);
begin
  A119MW.selT250AfterScroll(DataSet);
  inherited;
end;

procedure TWA119FDefinizioneScioperiDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A119MW.selT250BeforeDelete(DataSet);
end;

procedure TWA119FDefinizioneScioperiDM.BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  A119MW.selT250BeforeEdit(DataSet);
end;

procedure TWA119FDefinizioneScioperiDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A119MW.selT250BeforePost(DataSet);
end;

end.
