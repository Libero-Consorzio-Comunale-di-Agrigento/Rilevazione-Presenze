unit WP690UStampaFondiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR300UBaseDM, P690UStampaFondiMW;

type
  TWP690FStampaFondiDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    P690MW: TP690FStampaFondiMW;
  end;

implementation

{$R *.dfm}

procedure TWP690FStampaFondiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  P690MW:=TP690FStampaFondiMW.Create(Self);
end;

procedure TWP690FStampaFondiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(P690MW);
  inherited;
end;

end.
