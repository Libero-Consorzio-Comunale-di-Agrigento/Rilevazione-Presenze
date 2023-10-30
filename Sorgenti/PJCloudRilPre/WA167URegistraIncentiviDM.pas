unit WA167URegistraIncentiviDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR300UBaseDM, A167URegistraIncentiviMW;

type
  TWA167FRegistraIncentiviDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  public
    A167FRegistraIncentiviMW: TA167FRegistraIncentiviMW;
  end;

implementation

{$R *.dfm}

procedure TWA167FRegistraIncentiviDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  A167FRegistraIncentiviMW:=TA167FRegistraIncentiviMW.Create(Self);
end;

procedure TWA167FRegistraIncentiviDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A167FRegistraIncentiviMW);
  inherited;
end;

end.
