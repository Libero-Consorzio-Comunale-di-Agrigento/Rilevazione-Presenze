unit WP030UValuteDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, P030UValuteMW;

type
  TWP030FValuteDM = class(TWR302FGestTabellaDM)
    selTabellaCOD_VALUTA: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaABBREVIAZIONE: TStringField;
    selTabellaNUM_DEC_IMP_VOCE: TIntegerField;
    selTabellaNUM_DEC_IMP_UNIT: TIntegerField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    P030FValuteMW: TP030FValuteMW;
  end;


implementation

{$R *.dfm}

procedure TWP030FValuteDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY COD_VALUTA, DECORRENZA');
  P030FValuteMW:=TP030FValuteMW.Create(Self);
  P030FValuteMW.selP030:=selTabella;
  inherited;
end;

end.
