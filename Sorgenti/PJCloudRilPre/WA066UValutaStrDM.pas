unit WA066UValutaStrDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, A066UValutaStrMW;

type
  TWA066FValutaStrDM = class(TWR302FGestTabellaDM)
    selTabellaLIVELLO: TStringField;
    selTabellaCAUSALE: TStringField;
    selTabellaMAGGIORAZIONE: TFloatField;
    selTabellaTARIFFA_LIQ: TFloatField;
    selTabellaTARIFFA_MAT: TFloatField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
  private
    { Private declarations }
  public
    A066FValutaStrMW: TA066FValutaStrMW;
  end;



implementation

{$R *.dfm}

procedure TWA066FValutaStrDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  selTabella.SetVariable('ORDERBY','order by LIVELLO, CAUSALE, MAGGIORAZIONE,DECORRENZA');
  inherited;
  A066FValutaStrMW:=TA066FValutaStrMW.Create(Self);
  A066FValutaStrMW.selT730:=selTabella;
  selTabella.Open;
end;

end.
