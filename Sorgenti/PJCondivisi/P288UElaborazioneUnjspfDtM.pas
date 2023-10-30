unit P288UElaborazioneUnjspfDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStoricoDTM, Oracle, DB, OracleData;

type
  TP288FElaborazioneUnjspfDtM = class(TR004FGestStoricoDtM)
    delTab: TOracleQuery;
    insU120: TOracleQuery;
    selU100: TOracleDataSet;
    selV430: TOracleDataSet;
    delTab2: TOracleQuery;
    selU100_ID: TOracleDataSet;
    insU100: TOracleQuery;
    insU145: TOracleQuery;
    delU100: TOracleQuery;
    selT430: TOracleDataSet;
    insU130: TOracleQuery;
    selP040: TOracleDataSet;
    insU135: TOracleQuery;
    selT430a: TOracleDataSet;
    insU140: TOracleQuery;
    insU165: TOracleQuery;
    insU170: TOracleQuery;
    insU175: TOracleQuery;
    insU180: TOracleQuery;
    insU125: TOracleQuery;
    selSG101: TOracleDataSet;
    insU155: TOracleQuery;
    insU160: TOracleQuery;
    selSG101a: TOracleDataSet;
    selSG101b: TOracleDataSet;
    insU150: TOracleQuery;
    selP442: TOracleDataSet;
    selP430: TOracleDataSet;
    selU110: TOracleDataSet;
    selU112: TOracleDataSet;
    insU190: TOracleQuery;
    selDataCambio: TOracleQuery;
    selP442Prrate: TOracleQuery;
    selP200: TOracleDataSet;
    selSQL: TOracleQuery;
    delTab3: TOracleQuery;
    expU120: TOracleQuery;
    expU125: TOracleQuery;
    expU145: TOracleQuery;
    expU130: TOracleQuery;
    expU135: TOracleQuery;
    expU140: TOracleQuery;
    expU165: TOracleQuery;
    expU170: TOracleQuery;
    expU175: TOracleQuery;
    expU180: TOracleQuery;
    expU155: TOracleQuery;
    expU160: TOracleQuery;
    expU150: TOracleQuery;
    expU190: TOracleQuery;
    selU110Prec: TOracleDataSet;
    selU190Prec: TOracleDataSet;
    selP430a: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P288FElaborazioneUnjspfDtM: TP288FElaborazioneUnjspfDtM;

implementation

{$R *.dfm}

procedure TP288FElaborazioneUnjspfDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selP040.Open;
end;

end.
