unit A103UScaricoGiustDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R004UGESTSTORICODTM, Oracle, Db, OracleData, Variants;

type
  TA103FScaricoGiustDtM1 = class(TR004FGestStoricoDtM)
    dscI150: TDataSource;
    SelI150: TOracleDataSet;
    SelT030: TOracleDataSet;
    SelT265: TOracleDataSet;
    SelT040: TOracleDataSet;
    InsT040: TOracleDataSet;
    FormattaData: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A103FScaricoGiustDtM1: TA103FScaricoGiustDtM1;

implementation

{$R *.DFM}

procedure TA103FScaricoGiustDtM1.DataModuleCreate(Sender: TObject);
begin
  inherited;
  SelI150.Close;
  SelI150.Open;
  SelT265.Close;
  SelT265.Open;
end;

end.
