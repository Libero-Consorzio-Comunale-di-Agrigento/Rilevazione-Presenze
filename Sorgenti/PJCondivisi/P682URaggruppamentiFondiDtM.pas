unit P682URaggruppamentiFondiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, P682URaggruppamentiFondiMW;

type
  TP682FRaggruppamentiFondiDtM = class(TR004FGestStoricoDtM)
    selP682: TOracleDataSet;
    selP682COD_RAGGR: TStringField;
    selP682DESCRIZIONE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    P682FRaggruppamentiFondiMW: TP682FRaggruppamentiFondiMW;
  end;

var
  P682FRaggruppamentiFondiDtM: TP682FRaggruppamentiFondiDtM;

implementation

{$R *.dfm}

procedure TP682FRaggruppamentiFondiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selP682,[evBeforePostNoStorico,
                               evBeforeDelete,
                               evAfterDelete,
                               evAfterPost]);
  P682FRaggruppamentiFondiMW:=TP682FRaggruppamentiFondiMW.Create(Self);
  P682FRaggruppamentiFondiMW.selP682:=selP682;
  selP682.Open;
end;

end.
