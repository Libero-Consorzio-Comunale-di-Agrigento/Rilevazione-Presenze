unit WA074URiepilogoBuoniDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR300UBaseDM,A074URiepilogoBuoniMW;

type
  TWA074FRiepilogoBuoniDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    A074FRiepilogoBuoniMW:TA074FRiepilogoBuoniMW;
  end;

implementation

{$R *.dfm}

procedure TWA074FRiepilogoBuoniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  A074FRiepilogoBuoniMW:=TA074FRiepilogoBuoniMW.Create(Self);
end;

procedure TWA074FRiepilogoBuoniDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A074FRiepilogoBuoniMW);
  inherited;
end;

end.
