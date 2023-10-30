unit WA203UDatiMensiliPersonalizzatiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  A203UDatiMensiliPersonalizzatiMW;

type
  TWA203FDatiMensiliPersonalizzatiDM = class(TWR302FGestTabellaDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet);  override;
    procedure dsrTabellaStateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    A203MW:TA203FDatiMensiliPersonalizzatiMW;
  end;

implementation

uses WA203UDatiMensiliPersonalizzati, WA203UDatiMensiliPersonalizzatiDettFM;
{$R *.dfm}

procedure TWA203FDatiMensiliPersonalizzatiDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if assigned(A203MW) then
    A203MW.selI011AfterScroll(DataSet);
end;

procedure TWA203FDatiMensiliPersonalizzatiDM.dsrTabellaStateChange(Sender: TObject);
begin
  inherited;
  if ((Self.Owner as TWA203FDatiMensiliPersonalizzati).WDettaglioFM <> nil) then
    with ((Self.Owner as TWA203FDatiMensiliPersonalizzati).WDettaglioFM as TWA203FDatiMensiliPersonalizzatiDettFM) do
      EvtStateChange;
end;

procedure TWA203FDatiMensiliPersonalizzatiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  //NonAprireSelTabella:=True;

  //selTabella.Open;

  A203MW:=TA203FDatiMensiliPersonalizzatiMW.Create(self);
  A203MW.selI011:=selTabella;
  inherited;
  A203MW.InizializzaDataSet;

  selTabella.Open;

end;

end.
