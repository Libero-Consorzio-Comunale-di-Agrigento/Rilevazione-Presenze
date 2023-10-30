unit WA130UOraLegaleSolareDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR300UBaseDM, A130UOraLegaleSolareMW;

type
  TWA130FOraLegaleSolareDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
  private
    { Private declarations }
  public
    A130MW:TA130FOraLegaleSolareMW;
  end;


implementation

{$R *.dfm}

procedure TWA130FOraLegaleSolareDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  A130MW:=TA130FOraLegaleSolareMW.Create(Self);
end;

end.
