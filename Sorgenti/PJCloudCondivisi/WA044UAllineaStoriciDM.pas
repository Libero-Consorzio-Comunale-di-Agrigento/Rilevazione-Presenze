unit WA044UAllineaStoriciDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR300UBaseDM,A044UAllineaStoriciMW;

type
  TWA044FAllineaStoriciDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    A044FAllineaStoriciMW: TA044FAllineaStoriciMW;
  end;


implementation

{$R *.dfm}

procedure TWA044FAllineaStoriciDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  A044FAllineaStoriciMW:=TA044FAllineaStoriciMW.Create(Self);
end;

procedure TWA044FAllineaStoriciDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A044FAllineaStoriciMW);
end;

end.
