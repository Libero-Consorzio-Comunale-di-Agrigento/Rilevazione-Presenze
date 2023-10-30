unit WA168UIncentiviMaturatiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, OracleData,
  WR302UGestTabellaDM, WR303UGestMasterDetailDM, A000UInterfaccia, A168UIncentiviMaturatiMW;

type
  TWA168FIncentiviMaturatiDM = class(TWR303FGestMasterDetailDM)
    dsrT763: TDataSource;
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaANNO: TFloatField;
    selTabellaMESE: TFloatField;
    selTabellaDesc_Mese: TStringField;
    selTabellaCODTIPOQUOTA: TStringField;
    selTabellaDesc_Quota: TStringField;
    selTabellaTipologia_Quota: TStringField;
    selTabellaTIPOIMPORTO: TStringField;
    selTabellaDesc_Importo: TStringField;
    selTabellaIMPORTO: TFloatField;
    selTabellaVARIAZIONI: TFloatField;
    selTabellaGIORNI_ORE: TFloatField;
    selTabellaDescGiorniOre: TStringField;
    selTabellaRisparmio: TStringField;
    selTabellaTIPOCALCOLO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure OnNewRecord(DataSet: TDataSet); override;
  private
    { Private declarations }
  protected
    procedure RelazionaTabelleFiglie; override;
  public
    A168FIncentiviMaturatiMW: TA168FIncentiviMaturatiMW;
  end;

implementation

{$R *.dfm}

procedure TWA168FIncentiviMaturatiDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A168FIncentiviMaturatiMW.BeforeDelete(DataSet);
end;

procedure TWA168FIncentiviMaturatiDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A168FIncentiviMaturatiMW.BeforePostNoStorico(DataSet);
end;

procedure TWA168FIncentiviMaturatiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','order by anno DESC, mese DESC, CODtipoquota, tipoimporto');
  NonAprireSelTabella:=True;
  inherited;
  A168FIncentiviMaturatiMW:=TA168FIncentiviMaturatiMW.Create(Self);
  A168FIncentiviMaturatiMW.selT762:=selTabella;
  dsrT763.DataSet:=A168FIncentiviMaturatiMW.selT763;
  selTabella.FieldByName('DESC_QUOTA').LookupDataSet:=A168FIncentiviMaturatiMW.selT765;
  selTabella.FieldByName('TIPOLOGIA_QUOTA').LookupDataSet:=A168FIncentiviMaturatiMW.selT765;
  selTabella.FieldByName('RISPARMIO').LookupDataSet:=A168FIncentiviMaturatiMW.selT766;
end;

procedure TWA168FIncentiviMaturatiDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  A168FIncentiviMaturatiMW.selT762NewRecord(DataSet);
end;

procedure TWA168FIncentiviMaturatiDM.RelazionaTabelleFiglie;
begin
  with A168FIncentiviMaturatiMW.selT763 do
  begin
    Close;
    SetVariable('PROG',selTabella.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('ANNO',selTabella.FieldByName('ANNO').AsInteger);
    SetVariable('MESE',selTabella.FieldByName('MESE').AsInteger);
    SetVariable('QUOTA',selTabella.FieldByName('CODTIPOQUOTA').AsString);
    Open;
  end;
end;

procedure TWA168FIncentiviMaturatiDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  A168FIncentiviMaturatiMW.selT762CalcFields(DataSet);
end;

end.
