unit WA091ULiquidPresenzeDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR300UBaseDM, A091ULiquidPresenzeMW, DB;

type
  TWA091FLiquidPresenzeDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    A091FLiquidPresenzeMW: TA091FLiquidPresenzeMW;
  end;

implementation

{$R *.dfm}
procedure TWA091FLiquidPresenzeDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  A091FLiquidPresenzeMW:=TA091FLiquidPresenzeMW.Create(Self);
end;

procedure TWA091FLiquidPresenzeDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A091FLiquidPresenzeMW);
  inherited;
end;

end.
