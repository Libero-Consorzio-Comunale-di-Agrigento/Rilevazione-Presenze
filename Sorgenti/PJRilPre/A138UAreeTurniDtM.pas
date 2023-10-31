unit A138UAreeTurniDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGestTab, Oracle, DB, OracleData,
  C180FunzioniGenerali, A138UAreeTurniMW, A000UMessaggi, A000UInterfaccia, R004UGestStoricoDTM;

type
  TA138FAreeTurniDtM = class(TR004FGestStoricoDtM)
    selT650: TOracleDataSet;
    selT650CODICE: TStringField;
    selT650DESCRIZIONE: TStringField;
    selT650COLORE: TStringField;
    selT650SIGLA: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT650BeforeOpen(DataSet: TDataSet);
  private
  public
    A138MW: TA138FAreeTurniMW;
  end;

var
  A138FAreeTurniDtM: TA138FAreeTurniDtM;

implementation

uses A138UAreeTurni;

{$R *.dfm}

procedure TA138FAreeTurniDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT650,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  A138FAreeTurni.DButton.DataSet:=selT650;
  A138MW:=TA138FAreeTurniMW.Create(Self);
  A138MW.selT650:=selT650;
  selT650.Open;
end;

procedure TA138FAreeTurniDtM.selT650BeforeOpen(DataSet: TDataSet);
begin
  inherited;
  A138MW.selT650BeforeOpen;
end;

end.
