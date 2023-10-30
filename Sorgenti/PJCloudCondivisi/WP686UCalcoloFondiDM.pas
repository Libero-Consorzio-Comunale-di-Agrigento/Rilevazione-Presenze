unit WP686UCalcoloFondiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR300UBaseDM,
  P686UCalcoloFondiMW;

type
  TWP686FCalcoloFondiDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    P686FCalcoloFondiMW: TP686FCalcoloFondiMW;
  end;

implementation

uses WP686UCalcoloFondi;

{$R *.dfm}

procedure TWP686FCalcoloFondiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  P686FCalcoloFondiMW:=TP686FCalcoloFondiMW.Create(Self);
  P686FCalcoloFondiMW.evtRichiesta:=(Self.Owner as TWP686FCalcoloFondi).evtRichiesta;
end;

procedure TWP686FCalcoloFondiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(P686FCalcoloFondiMW);
  inherited;
end;

end.
