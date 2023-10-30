unit WA077UGeneratoreStampeDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR003UGeneratoreStampeDM, Data.DB,
  OracleData, Datasnap.DBClient, A077UGeneratoreStampeMW;

type
  TWA077FGeneratoreStampeDM = class(TWR003FGeneratoreStampeDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    function A077FGeneratoreStampeMW: TA077FGeneratoreStampeMW;
  end;

implementation

{$R *.dfm}

procedure TWA077FGeneratoreStampeDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  R003FGeneratoreStampeMW:=TA077FGeneratoreStampeMW.Create(Self);
  inherited;
end;

function TWA077FGeneratoreStampeDM.A077FGeneratoreStampeMW: TA077FGeneratoreStampeMW;
begin
  Result:=(R003FGeneratoreStampeMW as TA077FGeneratoreStampeMW);
end;

procedure TWA077FGeneratoreStampeDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(R003FGeneratoreStampeMW);
  inherited;
end;

end.
