unit P680UMacrocategorieFondiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, P680UMacrocategorieFondiMW;

type
  TP680FMacrocategorieFondiDtM = class(TR004FGestStoricoDtM)
    selP680: TOracleDataSet;
    selP680COD_MACROCATEG: TStringField;
    selP680DESCRIZIONE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    P680FMacrocategorieFondiMW: TP680FMacrocategorieFondiMW;
  end;

var
  P680FMacrocategorieFondiDtM: TP680FMacrocategorieFondiDtM;

implementation

{$R *.dfm}

procedure TP680FMacrocategorieFondiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selP680,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost,
                              evOnTranslateMessage]);
  P680FMacrocategorieFondiMW:=TP680FMacrocategorieFondiMW.Create(Self);
  P680FMacrocategorieFondiMW.selP680:=selP680;
  selP680.Open;
end;

end.
