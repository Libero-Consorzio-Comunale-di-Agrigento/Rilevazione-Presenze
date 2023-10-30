unit WA030UResiduiDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, A030UResiduiMW;

type
  TWA030FResiduiDM = class(TWR302FGestTabellaDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure AfterCancel(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet);  override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet);  override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    A030MW:TA030FResiduiMW;
  end;

implementation

{$R *.dfm}

procedure TWA030FResiduiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  A030MW:=TA030FResiduiMW.Create(Self);
end;

procedure TWA030FResiduiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  if A030MW <> nil then
    FreeAndNil(A030MW);
end;

procedure TWA030FResiduiDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  if selTabella = A030MW.Q130 then
    A030MW.Q130NewRecord(DataSet)
  else if selTabella = A030MW.selT131 then
    A030MW.selt131NewRecord(DataSet)
  else if selTabella = A030MW.T264 then
    A030MW.T264NewRecord(DataSet)
  else if selTabella = A030MW.selT692 then
    A030MW.selT692NewRecord(DataSet)
  else if selTabella = A030MW.selSG656 then
    A030MW.selSG656NewRecord(DataSet);
end;

procedure TWA030FResiduiDM.AfterCancel(DataSet: TDataSet);
begin
  inherited;
  if selTabella = A030MW.Q130 then
    A030MW.Q130AfterCancel(DataSet);
end;

procedure TWA030FResiduiDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  if selTabella = A030MW.Q130 then
    A030MW.Q130AfterDelete(DataSet)
  else if selTabella = A030MW.selT131 then
    A030MW.selT131AfterPost(DataSet)
  else if selTabella = A030MW.T264 then
    A030MW.T264AfterPost(DataSet)
  else if selTabella = A030MW.selT692 then
    A030MW.selT692AfterPost(DataSet)
  else if selTabella = A030MW.selSG656 then
    A030MW.SelSG656AfterPost(DataSet);
end;

procedure TWA030FResiduiDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  if selTabella = A030MW.Q130 then
    A030MW.Q130AfterPost(DataSet)
  else if selTabella = A030MW.selT131 then
    A030MW.selT131AfterPost(DataSet)
  else if selTabella = A030MW.T264 then
    A030MW.T264AfterPost(DataSet)
  else if selTabella = A030MW.selT692 then
    A030MW.selT692AfterPost(DataSet)
  else if selTabella = A030MW.selSG656 then
    A030MW.SelSG656AfterPost(DataSet);
end;

procedure TWA030FResiduiDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if selTabella = A030MW.T264 then
    A030MW.T264AfterScroll(DataSet);
end;

procedure TWA030FResiduiDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if selTabella = A030MW.Q130 then
    A030MW.Q130BeforeDelete(DataSet)
  else if selTabella = A030MW.selT131 then
    A030MW.selt131BeforeDelete(DataSet)
  else if selTabella = A030MW.T264 then
    A030MW.T264BeforeDelete(DataSet)
  else if selTabella = A030MW.selT692 then
    A030MW.selT692BeforeDelete(DataSet)
  else if selTabella = A030MW.selSG656 then
    A030MW.selSG656BeforeDelete(DataSet);
end;

procedure TWA030FResiduiDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  if selTabella = A030MW.Q130 then
    A030MW.Q130BeforePost(DataSet)
  else if selTabella = A030MW.selT131 then
    A030MW.selt131BeforePost(DataSet)
  else if selTabella = A030MW.T264 then
    A030MW.T264BeforePost(DataSet)
  else if selTabella = A030MW.selT692 then
    A030MW.selT692BeforePost(DataSet)
  else if selTabella = A030MW.selSG656 then
    A030MW.selSG656BeforePost(DataSet);
end;

end.
