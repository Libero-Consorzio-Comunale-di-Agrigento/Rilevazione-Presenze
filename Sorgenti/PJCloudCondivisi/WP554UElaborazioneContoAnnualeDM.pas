unit WP554UElaborazioneContoAnnualeDM;

interface

uses
  WR300UBaseDM, P554UElaborazioneContoAnnualeMW,
  System.SysUtils, System.Variants, System.Classes;

type
  TWP554FElaborazioneContoAnnualeDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  public
    P554MW: TP554FElaborazioneContoAnnualeMW;
  end;

implementation

{$R *.dfm}

procedure TWP554FElaborazioneContoAnnualeDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  P554MW:=TP554FElaborazioneContoAnnualeMW.Create(Self);
end;

procedure TWP554FElaborazioneContoAnnualeDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(P554MW);
  inherited;
end;

end.
