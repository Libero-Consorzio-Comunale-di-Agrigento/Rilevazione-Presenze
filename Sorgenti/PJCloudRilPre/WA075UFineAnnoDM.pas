unit WA075UFineAnnoDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR300UBaseDM, A075UFineAnnoMW;

type
  TWA075FFineAnnoDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    A075MW:TA075FFineAnnoMW;
  end;

implementation

{$R *.dfm}

procedure TWA075FFineAnnoDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  A075MW:=TA075FFineAnnoMW.Create(nil);
end;

procedure TWA075FFineAnnoDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A075MW);
end;

end.
