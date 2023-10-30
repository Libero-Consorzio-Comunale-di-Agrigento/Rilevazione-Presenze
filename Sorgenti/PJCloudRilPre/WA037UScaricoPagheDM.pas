unit WA037UScaricoPagheDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR300UBaseDM, DB, OracleData,A037UScaricoPagheMW;

type
  TWA037FScaricoPagheDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    A037FScaricoPagheMW: TA037FScaricoPagheMW;

  end;

implementation

{$R *.dfm}

procedure TWA037FScaricoPagheDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  A037FScaricoPagheMW:=TA037FScaricoPagheMW.Create(Self);
end;

procedure TWA037FScaricoPagheDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A037FScaricoPagheMW);
  inherited;

end;

end.
