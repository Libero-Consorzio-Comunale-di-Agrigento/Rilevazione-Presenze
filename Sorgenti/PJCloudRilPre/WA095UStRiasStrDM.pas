unit WA095UStRiasStrDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR300UBaseDM, A095UStRiasStrMW;

type
  TWA095FStRiasStrDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    A095FStRiasStrMW: TA095FStRiasStrMW;
  end;

implementation

{$R *.dfm}

procedure TWA095FStRiasStrDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  A095FStRiasStrMW:=TA095FStRiasStrMW.Create(Self);
end;

procedure TWA095FStRiasStrDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A095FStRiasStrMW);
  inherited;
end;

end.
