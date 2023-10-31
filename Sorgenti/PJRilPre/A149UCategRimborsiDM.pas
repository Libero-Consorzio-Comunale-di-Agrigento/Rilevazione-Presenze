unit A149UCategRimborsiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R004UGestStoricoDTM, Data.DB, OracleData;

type
  TA149FCategRimborsiDM = class(TR004FGestStoricoDtM)
    selM022: TOracleDataSet;
    selM022CODICE: TStringField;
    selM022DESCRIZIONE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A149FCategRimborsiDM: TA149FCategRimborsiDM;

implementation

{$R *.dfm}

procedure TA149FCategRimborsiDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selM022,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  selM022.Open;
end;

end.
