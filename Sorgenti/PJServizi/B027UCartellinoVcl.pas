unit B027UCartellinoVcl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses B027UCartellinoSrv;

procedure TForm1.Button1Click(Sender: TObject);
begin
  try
    B027FCartellinoSrv := TB027FCartellinoSrv.Create(nil);

    // Simulate service start.
    //B027FCartellinoSrv.ServiceStart(B027FCartellinoSrv, MyDummyBoolean);
    B027FCartellinoSrv.ServiceExecute(B027FCartellinoSrv);

    // Keep the console box running (ServerContainer1 code runs in the background)
    //ReadLn;

    // On exit, destroy the service object.
    FreeAndNil(B027FCartellinoSrv);
  except
    on E: Exception do
    begin
    end;
  end;

end;

end.
