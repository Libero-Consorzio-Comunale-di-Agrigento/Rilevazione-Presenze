unit WP656UElaborazioneFluperDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR300UBaseDM,
  P656UElaborazioneFluperMW;

type
  TWP656FElaborazioneFluperDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  public
    P656FElaborazioneFluperMW: TP656FElaborazioneFluperMW;
  end;

implementation

{$R *.dfm}

procedure TWP656FElaborazioneFluperDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  P656FElaborazioneFluperMW:=TP656FElaborazioneFluperMW.Create(Self);
end;

procedure TWP656FElaborazioneFluperDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(P656FElaborazioneFluperMW);
  inherited;
end;

end.
