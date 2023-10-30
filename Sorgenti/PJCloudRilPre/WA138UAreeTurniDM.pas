unit WA138UAreeTurniDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  A000UInterfaccia, A138UAreeTurniMW;

type
  TWA138FAreeTurniDM = class(TWR302FGestTabellaDM)
    selSG221CODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaSIGLA: TStringField;
    selTabellaCOLORE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    A138MW: TA138FAreeTurniMW;
  end;

implementation

{$R *.dfm}

procedure TWA138FAreeTurniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','order by CODICE');
  A138MW:=TA138FAreeTurniMW.Create(Self);
  A138MW.selT650:=selTabella;
  inherited;
end;

end.
