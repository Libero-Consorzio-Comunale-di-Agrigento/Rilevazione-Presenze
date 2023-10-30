unit WS750UParProtocolloDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, Data.DB,
  OracleData, S750UParProtocolloMW, A000UInterfaccia;

type
  TWS750FParProtocolloDM = class(TWR303FGestMasterDetailDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaTIPOXML: TStringField;
    selTabellaWS_URL: TStringField;
    D751: TDataSource;
    SG751: TOracleDataSet;
    SG751CODICE: TStringField;
    SG751ORDINE: TIntegerField;
    SG751TIPO: TStringField;
    SG751DESCRIZIONE: TStringField;
    SG751DATO: TStringField;
    selTabellaINVIO_CONSEGNA: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure CalcFields(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    S750FParProtocolloMW: TS750FParProtocolloMW;
  protected
    procedure RelazionaTabelleFiglie; override;
  end;

implementation

{$R *.dfm}

procedure TWS750FParProtocolloDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  S750FParProtocolloMW.BeforePostNoStorico;
end;

procedure TWS750FParProtocolloDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  inherited;

  S750FParProtocolloMW:=TS750FParProtocolloMW.Create(Self);
  S750FParProtocolloMW.SG750:=selTabella;
  S750FParProtocolloMW.SG751:=SG751;
  S750FParProtocolloMW.D751:=D751;

  SG751.Open;
end;

procedure TWS750FParProtocolloDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(S750FParProtocolloMW);
  inherited;
end;

procedure TWS750FParProtocolloDM.RelazionaTabelleFiglie;
begin
  with SG751 do
  begin
    Close;
    SetVariable('CODICE', selTabella.FieldByName('CODICE').AsString);
    Open;
  end;
end;

procedure TWS750FParProtocolloDM.AfterPost(DataSet: TDataSet);
begin
  S750FParProtocolloMW.AfterPost;
  inherited;
end;

procedure TWS750FParProtocolloDM.CalcFields(DataSet: TDataSet);
begin
  inherited;
  S750FParProtocolloMW.SG750CalcFields(DataSet);
end;

end.


