unit WA176URiepilogoIterAutorizzativiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  A176URiepilogoIterAutorizzativiMW;

type
  TWA176FRiepilogoIterAutorizzativiDM = class(TWR302FGestTabellaDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    A176MW:TA176FRiepilogoIterAutorizzativiMW;
  end;

implementation

{$R *.dfm}

procedure TWA176FRiepilogoIterAutorizzativiDM.IWUserSessionBaseCreate(
  Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  A176MW:=TA176FRiepilogoIterAutorizzativiMW.Create(nil);
end;

procedure TWA176FRiepilogoIterAutorizzativiDM.IWUserSessionBaseDestroy(
  Sender: TObject);
begin
  inherited;
  FreeAndNil(A176MW);
end;

end.
