unit B009UPuntoInformativoDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R004UGESTSTORICODTM, Oracle, Db, OracleData, Variants;

type
  TB009FPuntoInformativoDtM1 = class(TR004FGestStoricoDtM)
    SelT430: TOracleDataSet;
    SelT070: TOracleDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  B009FPuntoInformativoDtM1: TB009FPuntoInformativoDtM1;

implementation

{$R *.DFM}

end.
