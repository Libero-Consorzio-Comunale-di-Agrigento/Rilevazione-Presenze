unit WP682URaggruppamentiFondiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, P682URaggruppamentiFondiMW;

type
  TWP682FRaggruppamentiFondiDM = class(TWR302FGestTabellaDM)
    selTabellaCOD_RAGGR: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    P682FRaggruppamentiFondiMW: TP682FRaggruppamentiFondiMW;
  end;

implementation

{$R *.dfm}

procedure TWP682FRaggruppamentiFondiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY COD_RAGGR');
  P682FRaggruppamentiFondiMW:=TP682FRaggruppamentiFondiMW.Create(Self);
  P682FRaggruppamentiFondiMW.selP682:=selTabella;
  inherited;
end;

end.
