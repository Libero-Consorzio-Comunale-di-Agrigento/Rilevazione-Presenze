unit WP688UMonitoraggioFondiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR300UBaseDM,
  P688UMonitoraggioFondiMW;

type
  TWP688FMonitoraggioFondiDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    P688FMonitoraggioFondiMW: TP688FMonitoraggioFondiMW;
  end;

implementation

{$R *.dfm}

procedure TWP688FMonitoraggioFondiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  P688FMonitoraggioFondiMW:=TP688FMonitoraggioFondiMW.Create(Self);
end;

procedure TWP688FMonitoraggioFondiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(P688FMonitoraggioFondiMW);
  inherited;
end;

end.
