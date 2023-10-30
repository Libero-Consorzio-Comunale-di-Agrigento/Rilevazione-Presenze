unit WP680UMacrocategorieFondiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, P680UMacrocategorieFondiMW;

type
  TWP680FMacrocategorieFondiDM = class(TWR302FGestTabellaDM)
    selTabellaCOD_MACROCATEG: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    P680FMacrocategorieFondiMW: TP680FMacrocategorieFondiMW;
  end;

implementation

{$R *.dfm}

procedure TWP680FMacrocategorieFondiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY COD_MACROCATEG');
  P680FMacrocategorieFondiMW:=TP680FMacrocategorieFondiMW.Create(Self);
  P680FMacrocategorieFondiMW.selP680:=selTabella;
  inherited;
end;

end.
