unit WS130UOrdiniProfessionaliDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  A000UInterfaccia, S130UOrdiniProfessionaliMW;

type
  TWS130FOrdiniProfessionaliDM = class(TWR302FGestTabellaDM)
    selSG221COD_ORDINE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaQUALIFICHE_COLLEGATE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    S130MW: TS130FOrdiniProfessionaliMW;
  end;

implementation

{$R *.dfm}

procedure TWS130FOrdiniProfessionaliDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','order by cod_ordine');
  selTabellaQUALIFICHE_COLLEGATE.DisplayLabel:='Valori ' + Parametri.CampiRiferimento.C36_OrdProfSanCodice+' collegati';
  S130MW:=TS130FOrdiniProfessionaliMW.Create(Self);
  S130MW.selSG221:=selTabella;
  inherited;
end;

end.
