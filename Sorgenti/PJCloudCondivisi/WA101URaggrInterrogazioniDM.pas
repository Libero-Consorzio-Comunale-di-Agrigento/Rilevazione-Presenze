unit WA101URaggrInterrogazioniDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, Data.DB,
  OracleData, A101URaggrInterrogazioniMW, C180FunzioniGenerali, A000USessione, A000UInterfaccia;

type
  TWA101FRaggrInterrogazioniDM = class(TWR303FGestMasterDetailDM)
    selTabellaID: TFloatField;
    selTabellaDESCRIZIONE: TStringField;
    selT006: TOracleDataSet;
    selT006ID: TFloatField;
    selT006COD_QUERY: TStringField;
    dsrT006: TDataSource;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selT006BeforePost(DataSet: TDataSet);
    procedure selT006BeforeDelete(DataSet: TDataSet);
    procedure selT006BeforeEdit(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    A101MW:TA101FRaggrInterrogazioniMW;
    procedure RelazionaTabelleFiglie; override;
    procedure OpenSelT006(IDRaggr:integer);
  end;

implementation

{$R *.dfm}

procedure TWA101FRaggrInterrogazioniDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  //Incremento sequence T005 solo se è inserimento record
  if selTabella.State in [dsInsert] then
    selTabella.FieldByName('ID').AsInteger:=A101MW.GetSeqT005;
end;

procedure TWA101FRaggrInterrogazioniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  A101MW:=TA101FRaggrInterrogazioniMW.Create(Self);
end;

procedure TWA101FRaggrInterrogazioniDM.OpenSelT006(IDRaggr:integer);
begin
  R180SetVariable(selT006,'ID_RAGGR',IDRaggr);
  R180SetVariable(selT006,'APPLICAZIONE',Parametri.Applicazione);
  selT006.Open;
end;

procedure TWA101FRaggrInterrogazioniDM.RelazionaTabelleFiglie;
begin
  OpenSelT006(selTabella.FieldByName('ID').AsInteger);
end;

procedure TWA101FRaggrInterrogazioniDM.selT006BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if not A000FiltroDizionario('INTERROGAZIONI DI SERVIZIO',DataSet.FieldByName('COD_QUERY').AsString) then
    raise Exception.Create(Format('Impossibile cancellare l''interrogazione di servizio %s, operazione inibita da filtro dizionario.',[DataSet.FieldByName('COD_QUERY').AsString]));
end;

procedure TWA101FRaggrInterrogazioniDM.selT006BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if not A000FiltroDizionario('INTERROGAZIONI DI SERVIZIO',DataSet.FieldByName('COD_QUERY').AsString) then
    raise Exception.Create(Format('Impossibile modificare l''interrogazione di servizio %s, operazione inibita da filtro dizionario.',[DataSet.FieldByName('COD_QUERY').AsString]));
end;

procedure TWA101FRaggrInterrogazioniDM.selT006BeforePost(DataSet: TDataSet);
begin
  inherited;
  selT006.FieldByName('ID').AsInteger:=selTabella.FieldByName('ID').AsInteger;
end;

end.
