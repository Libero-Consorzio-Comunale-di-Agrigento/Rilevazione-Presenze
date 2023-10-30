unit WA062UQueryServizioDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, A000UCostanti, A000USessione, A000UInterfaccia, A062UQueryServizioMW;

type
  TWA062FQueryServizioDM = class(TWR302FGestTabellaDM)
    selTabellaNOME: TStringField;
    selTabellaRAGGRUPPAMENTO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure AfterScroll(DataSet: TDataSet); override;
  public
    A062MW:TA062FQueryServizioMW;
  end;

implementation

uses WA062UQueryServizio;

{$R *.dfm}

procedure TWA062FQueryServizioDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  A062MW:=TA062FQueryServizioMW.Create(nil);
  A062MW.selT002:=SelTabella;
  SelTabella.Filtered:=True;
  SelTabella.SetVariable('APPLICAZIONE',Parametri.Applicazione);
  SelTabella.SetVariable('ORDERBY','order by upper(NOME)');

  inherited;
end;

procedure TWA062FQueryServizioDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A062MW);
  inherited;
end;

procedure TWA062FQueryServizioDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;

  (Self.Owner as TWA062FQueryServizio).RisultatiInvalidati:=False;

  if (Self.Owner as TWA062FQueryServizio).WA062RisultatiFM <> nil then
    (Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.grdRisultati.DataSource:=nil;
end;

procedure TWA062FQueryServizioDM.selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  A062MW.SelT002FiltraRecord(DataSet,Accept);
end;

end.
