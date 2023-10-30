unit WA041UInsRiposiDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR300UBaseDM, A041UInsRiposiMW;

type
  TWA041FInsRiposiDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  public
    A041FInsRiposiMW: TA041FInsRiposiMW;
  end;

implementation

{$R *.dfm}

procedure TWA041FInsRiposiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  A041FInsRiposiMW:=TA041FInsRiposiMW.Create(Self);
end;

procedure TWA041FInsRiposiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A041FInsRiposiMW);
end;

end.
