unit S028UMotivazioniDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, S028UMotivazioniMW;

type
  TS028FMotivazioniDtM = class(TR004FGestStoricoDtM)
    selSG104: TOracleDataSet;
    selSG104CODICE: TStringField;
    selSG104DESCRIZIONE: TStringField;
    selSG104DESCRIZIONE_AGG: TStringField;
    selSG104STAMPA_FAMILIARI: TStringField;
    selSG104ELENCO_NUMERI_PREC: TStringField;
    selSG104ELENCO_NUMERI_SUCC: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    S028MW:TS028FMotivazioniMW;
  end;

var
  S028FMotivazioniDtM: TS028FMotivazioniDtM;

implementation

{$R *.dfm}

procedure TS028FMotivazioniDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selSG104,[evBeforePostNoStorico,
                               evBeforeDelete,
                               evAfterDelete,
                               evAfterPost]);
  selSG104.Open;
  S028MW:=TS028FMotivazioniMW.Create(nil);
  S028MW.selP660.Open;
end;

procedure TS028FMotivazioniDtM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(S028MW);
end;

end.
