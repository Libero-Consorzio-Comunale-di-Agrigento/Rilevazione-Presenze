unit WA178UPianifPersConvDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, Data.DB,
  OracleData, A178UPianifPersConvMW;

type
  TWA178FPianifPersConvDM = class(TWR303FGestMasterDetailDM)
    selT421: TOracleDataSet;
    dsrT421: TDataSource;
    selTabellaPROGRESSIVO: TIntegerField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaID: TFloatField;
    selT421ID: TFloatField;
    selT421GIORNO: TIntegerField;
    selT421D_GIORNO: TStringField;
    selT421DALLE: TStringField;
    selT421ALLE: TStringField;
    selT421STRUTTURA: TStringField;
    selT421RESPONSABILE: TStringField;
    selT421RESPONSABILI_CC: TStringField;
    selT421NOTE: TStringField;
    selT421TOLL_DALLE: TStringField;
    selT421TOLL_ALLE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selT421CalcFields(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure selT421NewRecord(DataSet: TDataSet);
    procedure selT421BeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    A178MW: TA178FPianifPersConvMW;
  protected
    procedure RelazionaTabelleFiglie; override;
  end;

implementation

{$R *.dfm}

procedure TWA178FPianifPersConvDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A178MW.selT420AfterPost;
end;

procedure TWA178FPianifPersConvDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  SelTabella.SetVariable('ORDERBY','ORDER BY DECORRENZA');
  selT421.SetVariable('ORDERBY','ORDER BY GIORNO, DALLE');
  NonAprireSelTabella:=True;
  inherited;
  A178MW:=TA178FPianifPersConvMW.Create(Self);
  A178MW.selT420:=selTabella;
  A178MW.selT421:=selT421;
  selTabella.Open;
  selT421.Open;
  SetTabelleRelazionate([selTabella,selT421]);
end;

procedure TWA178FPianifPersConvDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  A178MW.selT420NewRecord;
end;

procedure TWA178FPianifPersConvDM.RelazionaTabelleFiglie;
begin
  inherited;
  selT421.DisableControls;
  A178MW.selT420AfterScroll;
  selT421.EnableControls;
end;

procedure TWA178FPianifPersConvDM.selT421BeforePost(DataSet: TDataSet);
begin
  inherited;
  A178MW.selT421BeforePost;
end;

procedure TWA178FPianifPersConvDM.selT421CalcFields(DataSet: TDataSet);
begin
  inherited;
  A178MW.selT421CalcFields;
end;

procedure TWA178FPianifPersConvDM.selT421NewRecord(DataSet: TDataSet);
begin
  inherited;
  A178MW.selT421NewRecord;
end;

end.
