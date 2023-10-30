unit WS715UStampaValutazioniDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR300UBaseDM, S715UStampaValutazioniMW;

type
  TWS715FStampaValutazioniDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    S715FStampaValutazioniMW: TS715FStampaValutazioniMW;
  end;

implementation

{$R *.dfm}

procedure TWS715FStampaValutazioniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  S715FStampaValutazioniMW:=TS715FStampaValutazioniMW.Create(Self);
end;

procedure TWS715FStampaValutazioniDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(S715FStampaValutazioniMW);
  inherited;
end;

end.
