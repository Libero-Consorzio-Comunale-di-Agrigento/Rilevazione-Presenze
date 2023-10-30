unit WA023UTimbratureDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR300UBaseDM, A023UTimbratureMW;

type
  TWA023FTimbratureDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    A023FTimbratureMW: TA023FTimbratureMW;
  end;

implementation

{$R *.dfm}

procedure TWA023FTimbratureDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  A023FTimbratureMW:=TA023FTimbratureMW.Create(Self);
end;

procedure TWA023FTimbratureDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A023FTimbratureMW);
  inherited;
end;

end.
