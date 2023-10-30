unit WA096UProfiliLibProfDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, WR303UGestMasterDetailDM, A096UProfiliLibProfMW;

type
  TWA096FProfiliLibProfDM = class(TWR303FGestMasterDetailDM)
    Q311: TOracleDataSet;
    Q311CODICE: TStringField;
    Q311D_GIORNO: TStringField;
    Q311DALLE: TStringField;
    Q311ALLE: TStringField;
    Q311CAUSALE: TStringField;
    Q311D_CAUSALE: TStringField;
    D311: TDataSource;
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    Q311GIORNO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure Q311BeforePost(DataSet: TDataSet);
    procedure Q311CalcFields(DataSet: TDataSet);
    procedure Q311NewRecord(DataSet: TDataSet);
    procedure Q311DALLEValidate(Sender: TField);
    procedure Q311CAUSALEValidate(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
    A096MW: TA096FProfiliLibProfMW;
  protected
    procedure RelazionaTabelleFiglie; override;
  end;

implementation

{$R *.dfm}

procedure TWA096FProfiliLibProfDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  SelTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  A096MW:=TA096FProfiliLibProfMW.Create(Self);
  A096MW.selT310:=selTabella;
  A096MW.selT311:=Q311;
  Q311.SetVariable('ORDERBY','ORDER BY GIORNO,DALLE');
  inherited;
  SetTabelleRelazionate([selTabella,Q311]);
end;

procedure TWA096FProfiliLibProfDM.RelazionaTabelleFiglie;
begin
  inherited;
  if not InterfacciaWR102.StoricizzazioneInCorso then
    A096MW.selT310AfterScroll;
end;

procedure TWA096FProfiliLibProfDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A096MW.selT310BeforeDelete;
end;

procedure TWA096FProfiliLibProfDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A096MW.selT310BeforePost;
end;

procedure TWA096FProfiliLibProfDM.Q311BeforePost(DataSet: TDataSet);
begin
  A096MW.selT311BeforePost;
end;

procedure TWA096FProfiliLibProfDM.Q311CalcFields(DataSet: TDataSet);
begin
  A096MW.selT311CalcFields;
end;

procedure TWA096FProfiliLibProfDM.Q311NewRecord(DataSet: TDataSet);
begin
  A096MW.selT311NewRecord;
end;

procedure TWA096FProfiliLibProfDM.Q311DALLEValidate(Sender: TField);
begin
  A096MW.selT311DALLEValidate(Sender);
end;

procedure TWA096FProfiliLibProfDM.Q311CAUSALEValidate(Sender: TField);
begin
  A096MW.selT311CAUSALEValidate(Sender);
end;

end.
