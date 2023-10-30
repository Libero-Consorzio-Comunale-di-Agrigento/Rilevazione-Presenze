unit WA047UTimbMensaDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR300UBaseDM, A047UTimbMensaMW;

type
  TWA047FTimbMensaDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    A047FTimbMensaMW: TA047FTimbMensaMW;
  end;

implementation

{$R *.dfm}

procedure TWA047FTimbMensaDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  A047FTimbMensaMW:=TA047FTimbMensaMW.Create(Self);
end;

procedure TWA047FTimbMensaDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A047FTimbMensaMW);
  inherited;
end;

end.
