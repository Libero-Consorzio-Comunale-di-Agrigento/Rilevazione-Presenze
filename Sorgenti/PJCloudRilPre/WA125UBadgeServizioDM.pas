unit WA125UBadgeServizioDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, A125UBadgeServizioMW;

type
  TWA125FBadgeServizioDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TIntegerField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaSCADENZA: TDateTimeField;
    selTabellaBADGESERV: TFloatField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterPost(DataSet: TDataSet);Override;
    procedure OnNewRecord(DataSet: TDataSet);Override;
    procedure BeforePostNoStorico(DataSet: TDataSet);Override;
  private
    { Private declarations }
  public
    A125MW:TA125FBadgeServizioMW;
  end;

implementation

uses WA125UBadgeServizio;

{$R *.dfm}

procedure TWA125FBadgeServizioDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY DECORRENZA DESC');
  inherited;
  A125MW:=TA125FBadgeServizioMW.Create(Self);
  A125MW.Q435:=SelTabella;
end;

procedure TWA125FBadgeServizioDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A125MW.Q435AfterPost;
end;

procedure TWA125FBadgeServizioDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A125MW.Q435BeforePost;
end;

procedure TWA125FBadgeServizioDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  SelTabella.FieldByName('PROGRESSIVO').AsInteger:=(Self.Owner as TWA125FBadgeServizio).grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

end.
