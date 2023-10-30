unit WA135UTimbratureScartateDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR303UGestMasterDetailDM, DB, OracleData;

type
  TWA135FTimbratureScartateDM = class(TWR303FGestMasterDetailDM)
    selT100: TOracleDataSet;
    FloatField1: TFloatField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaDATA: TDateTimeField;
    selTabellaORA: TDateTimeField;
    selTabellaVERSO: TStringField;
    selTabellaFLAG: TStringField;
    selTabellaRILEVATORE: TStringField;
    selTabellaCAUSALE: TStringField;
    dsrT100: TDataSource;
   procedure RelazionaTabelleFiglie;override;
   procedure DateTimeField2GetText(Sender: TField; var Text: string; DisplayText: Boolean);
   procedure selT103ORAGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure BeforeInsert(DataSet: TDataSet);Override;
    procedure AfterScroll(DataSet: TDataSet);Override;
    procedure IWUserSessionBaseCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses WA135UTimbratureScartate;

{$R *.dfm}

procedure TWA135FTimbratureScartateDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  with selT100 do
  begin
    Close;
    SetVariable('PROGRESSIVO',(Self.Owner as TWA135FTimbratureScartate).grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('DATAGIORNO',selTabella.FieldByName('DATA').AsDateTime);
    Open;
  end;
end;

procedure TWA135FTimbratureScartateDM.BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  Abort;
end;

procedure TWA135FTimbratureScartateDM.DateTimeField2GetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then Text:='' else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

procedure TWA135FTimbratureScartateDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selT100.SetVariable('ORDERBY','order by data, ora');
  selTabella.SetVariable('ORDERBY','order by data, ora');
  inherited;
end;

procedure TWA135FTimbratureScartateDM.RelazionaTabelleFiglie;
begin
  inherited;
  selT100.DisableControls;
  selT100.Close;
  selT100.SetVariable('PROGRESSIVO',SelTabella.FieldByName('PROGRESSIVO').AsInteger);
  selT100.SetVariable('DATAGIORNO',selTabella.FieldByName('DATA').AsDateTime);
  selT100.Open;
  selT100.EnableControls;
end;

procedure TWA135FTimbratureScartateDM.selT103ORAGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then Text:='' else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

end.
