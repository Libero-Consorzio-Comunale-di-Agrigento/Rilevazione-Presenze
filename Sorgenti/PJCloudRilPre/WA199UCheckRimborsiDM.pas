unit WA199UCheckRimborsiDM;

interface

uses
  A100UCheckRimborsiMW, A000UInterfaccia,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, Data.DB,
  OracleData;

type
  TWA199FCheckRimborsiDM = class(TWR303FGestMasterDetailDM)
    selTabellaNOMINATIVO: TStringField;
    selTabellaMATRICOLA: TStringField;
    selTabellaDATADA: TDateTimeField;
    selTabellaORADA: TStringField;
    selTabellaDATAA: TDateTimeField;
    selTabellaORAA: TStringField;
    selTabellaPARTENZA: TStringField;
    selTabellaD_PARTENZA: TStringField;
    selTabellaDESTINAZIONE: TStringField;
    selTabellaD_DESTINAZIONE: TStringField;
    selTabellaTIPOREGISTRAZIONE: TStringField;
    selTabellaFLAG_DESTINAZIONE: TStringField;
    selTabellaFLAG_ISPETTIVA: TStringField;
    selTabellaSTATO: TStringField;
    selTabellaD_RESIDENZA: TStringField;
    selTabellaMESESCARICO: TDateTimeField;
    selTabellaMESECOMPETENZA: TDateTimeField;
    selTabellaTOTALEGG: TFloatField;
    selTabellaDURATA: TStringField;
    selTabellaID_MISSIONE: TIntegerField;
    selTabellaPROTOCOLLO: TStringField;
    selTabellaCOMMESSA: TStringField;
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaD_FLAG_DESTINAZIONE: TStringField;
    selTabellaD_FLAG_ISPETTIVA: TStringField;
    selTabellaD_STATO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selTabellaAfterOpen(DataSet: TDataSet);
    procedure selTabellaAfterRefresh(DataSet: TDataSet);
  protected
    procedure RelazionaTabelleFiglie; override;
  public
    A100FCheckRimborsiMW: TA100FCheckRimborsiMW;
  end;

implementation

uses WA199UCheckRimborsi;

{$R *.dfm}

{ TWA199FCheckRimborsiDM }

procedure TWA199FCheckRimborsiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  A100FCheckRimborsiMW:=TA100FCheckRimborsiMW.Create(Self);
  A100FCheckRimborsiMW.selM040CheckRimb_Funzioni:=selTabella;
end;

procedure TWA199FCheckRimborsiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A100FCheckRimborsiMW);
  inherited;
end;

procedure TWA199FCheckRimborsiDM.RelazionaTabelleFiglie;
begin
  inherited;
  A100FCheckRimborsiMW.AggiornaDatasetDetail;
end;

procedure TWA199FCheckRimborsiDM.selTabellaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RelazionaTabelleFiglie;
  (Self.Owner as TWA199FCheckRimborsi).AggiornaDetails;
end;

procedure TWA199FCheckRimborsiDM.selTabellaAfterRefresh(DataSet: TDataSet);
begin
  inherited;
  RelazionaTabelleFiglie;
  (Self.Owner as TWA199FCheckRimborsi).AggiornaDetails;
end;

end.
