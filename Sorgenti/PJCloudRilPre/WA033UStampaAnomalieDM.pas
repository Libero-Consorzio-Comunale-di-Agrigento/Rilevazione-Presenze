unit WA033UStampaAnomalieDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR300UBaseDM,A033UStampaAnomalieMW;

type
  TWA033FStampaAnomalieDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    A033FStampaAnomalieMW: TA033FStampaAnomalieMW;
  end;

implementation

{$R *.dfm}

procedure TWA033FStampaAnomalieDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  A033FStampaAnomalieMW:=TA033FStampaAnomalieMW.Create(Self);
end;

procedure TWA033FStampaAnomalieDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A033FStampaAnomalieMW);
end;

end.
