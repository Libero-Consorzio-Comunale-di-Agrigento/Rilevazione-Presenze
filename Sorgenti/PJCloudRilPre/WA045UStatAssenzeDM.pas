unit WA045UStatAssenzeDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR300UBaseDM, DB, OracleData;

type
  TWA045FStatAssenzeDM = class(TWR300FBaseDM)
    QSceltaQualif: TOracleDataSet;
    QTipiRapporto: TOracleDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

end.
