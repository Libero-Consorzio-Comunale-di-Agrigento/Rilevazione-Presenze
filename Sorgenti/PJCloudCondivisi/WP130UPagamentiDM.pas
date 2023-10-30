unit WP130UPagamentiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, P130UPagamentiMW;

type
  TWP130FPagamentiDM = class(TWR302FGestTabellaDM)
    selTabellaCOD_PAGAMENTO: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaMOD_PAGAMENTO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    P130FPagamentiMW: TP130FPagamentiMW;
  end;


implementation

{$R *.dfm}

procedure TWP130FPagamentiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY COD_PAGAMENTO');
  P130FPagamentiMW:=TP130FPagamentiMW.Create(Self);
  P130FPagamentiMW.selP130:=selTabella;
  inherited;
end;

end.
