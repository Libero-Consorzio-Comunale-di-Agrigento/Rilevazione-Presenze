unit WA097UPianifLibProfDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, A097UPianifLibProfMW;

type
  TWA097FPianifLibProfDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaDATA: TDateTimeField;
    selTabellaD_GIORNO: TStringField;
    selTabellaDALLE: TStringField;
    selTabellaALLE: TStringField;
    selTabellaCAUSALE: TStringField;
    selTabellaD_CAUSALE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaDALLEValidate(Sender: TField);
    procedure selTabellaCAUSALEValidate(Sender: TField);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure OnNewRecord(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    A097MW: TA097FPianifLibProfMW;
  end;

implementation

{$R *.dfm}

procedure TWA097FPianifLibProfDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY DATA, DALLE');
  A097MW:=TA097FPianifLibProfMW.Create(Self);
  A097MW.selT320:=SelTabella;
  inherited;
end;

procedure TWA097FPianifLibProfDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  A097MW.selT320BeforePost;
end;

procedure TWA097FPianifLibProfDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  A097MW.selT320CalcFields;
end;

procedure TWA097FPianifLibProfDM.selTabellaCAUSALEValidate(Sender: TField);
begin
  A097MW.selT320CAUSALEValidate(Sender);
end;

procedure TWA097FPianifLibProfDM.selTabellaDALLEValidate(Sender: TField);
begin
  A097MW.selT320DALLEValidate(Sender);
end;

procedure TWA097FPianifLibProfDM.OnNewRecord(DataSet: TDataSet);
begin
  A097MW.selT320NewRecord;
end;

end.
