unit P688UMonitoraggioFondiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, P688UMonitoraggioFondiMW;

type
  TP688FMonitoraggioFondiDtM = class(TR004FGestStoricoDtM)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    P688FMonitoraggioFondiMW: TP688FMonitoraggioFondiMW;
  end;

var
  P688FMonitoraggioFondiDtM: TP688FMonitoraggioFondiDtM;

implementation

uses P688UMonitoraggioFondi;

{$R *.dfm}

procedure TP688FMonitoraggioFondiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  P688FMonitoraggioFondiMW:=TP688FMonitoraggioFondiMW.Create(Self);
  P688FMonitoraggioFondi.dgrdDettaglio.DataSource:=P688FMonitoraggioFondiMW.dsrDati;
end;

procedure TP688FMonitoraggioFondiDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(P688FMonitoraggioFondiMW);
  inherited;
end;

end.
