unit WA085UPartTimeDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient;

type
  TWA085FPartTimeDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaTIPO: TStringField;
    selTabellaPIANTA: TFloatField;
    selTabellaINDPRES: TFloatField;
    selTabellaINCENTIVI: TFloatField;
    selTabellaASSENZEGG: TFloatField;
    selTabellaASSENZEHH: TFloatField;
    selTabellaINDFEST: TFloatField;
    selTabellaDESCRIZIONE_ESTESA: TStringField;
    selTabellaDEBITO_AGG: TFloatField;
    selTabellaHHGIORNALIERE: TFloatField;
    procedure ValidaPercentuale(Sender: TField);
  private
    { Private declarations }
  public
  end;

implementation

uses A000UMessaggi;

{$R *.dfm}

procedure TWA085FPartTimeDM.ValidaPercentuale(Sender: TField);
begin
  if (Sender.AsFloat < 0) or (Sender.AsFloat > 100) then
    raise Exception.Create(A000MSG_A085_ERR_VALORE_PERCENTUALE);

end;

end.
