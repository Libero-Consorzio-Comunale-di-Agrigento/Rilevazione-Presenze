unit P553URisorseResidueContoAnnualeMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData;

type
  TP553FRisorseResidueContoAnnualeMW = class(TR005FDataModuleMW)
    selP552: TOracleDataSet;
    QSQL: TOracleDataSet;
    selT470: TOracleDataSet;
    dsrT470: TDataSource;
  private
    FSelP553: TOracleDataSet;
  public
    property SelT553_Funzioni: TOracleDataset read FSelP553 write FSelP553;
  end;

implementation

{$R *.dfm}

end.
