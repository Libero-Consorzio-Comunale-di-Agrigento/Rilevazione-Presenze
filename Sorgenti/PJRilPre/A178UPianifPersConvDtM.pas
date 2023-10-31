unit A178UPianifPersConvDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Oracle, Db, OracleData, Variants, StrUtils, C700USelezioneAnagrafe,
  A000UCostanti, A000USessione, A000UInterfaccia, R004UGestStoricoDtM, A178UPianifPersConvMW,
  C180FunzioniGenerali, A000UMessaggi;

type
  TA178FPianifPersConvDtM = class(TR004FGestStoricoDtM)
    selT420: TOracleDataSet;
    selT420PROGRESSIVO: TIntegerField;
    selT420DECORRENZA: TDateTimeField;
    selT420DECORRENZA_FINE: TDateTimeField;
    selT420ID: TFloatField;
    selT421: TOracleDataSet;
    dsrT421: TDataSource;
    selT421ID: TFloatField;
    selT421GIORNO: TIntegerField;
    selT421DALLE: TStringField;
    selT421ALLE: TStringField;
    selT421STRUTTURA: TStringField;
    selT421RESPONSABILE: TStringField;
    selT421RESPONSABILI_CC: TStringField;
    selT421NOTE: TStringField;
    selT421D_GIORNO: TStringField;
    selT421TOLL_DALLE: TStringField;
    selT421TOLL_ALLE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure selT420AfterScroll(DataSet: TDataSet);
    procedure selT421NewRecord(DataSet: TDataSet);
    procedure selT421CalcFields(DataSet: TDataSet);
    procedure selT421BeforePost(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure selT421BeforeInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    A178MW: TA178FPianifPersConvMW;
  end;

var
  A178FPianifPersConvDtM: TA178FPianifPersConvDtM;

implementation

uses A178UPianifPersConv;

{$R *.DFM}

procedure TA178FPianifPersConvDtM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A178MW.selT420AfterPost;
end;

procedure TA178FPianifPersConvDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A178FPianifPersConv.InterfacciaR004;
  InizializzaDataSet(selT420,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePost,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnNewRecord,
                           evOnTranslateMessage]);

  A178MW:=TA178FPianifPersConvMW.Create(Self);
  A178MW.selT420:=selT420;
  A178MW.selT421:=selT421;
end;

procedure TA178FPianifPersConvDtM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  A178MW.selT420NewRecord;
end;

procedure TA178FPianifPersConvDtM.selT420AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A178MW.selT420AfterScroll;
end;

procedure TA178FPianifPersConvDtM.selT421BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  A178MW.selT421BeforeInsert;
end;

procedure TA178FPianifPersConvDtM.selT421BeforePost(DataSet: TDataSet);
begin
  inherited;
  A178MW.selT421BeforePost;
end;

procedure TA178FPianifPersConvDtM.selT421CalcFields(DataSet: TDataSet);
begin
  inherited;
  A178MW.selT421CalcFields;
end;

procedure TA178FPianifPersConvDtM.selT421NewRecord(DataSet: TDataSet);
begin
  inherited;
  A178MW.selT421NewRecord;
end;

end.
