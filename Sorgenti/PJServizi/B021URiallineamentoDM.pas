unit B021URiallineamentoDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, Oracle, DB, OracleData, RegistrazioneLog,
  A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali;

type
  TB021FRiallineamentoDM = class(TR004FGestStoricoDtM)
    selStep1: TOracleDataSet;
    selStep2: TOracleDataSet;
    selStep3: TOracleDataSet;
    selStep4: TOracleDataSet;
    selStep5: TOracleDataSet;
    scrPrepara: TOracleScript;
    scrTermina: TOracleScript;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  B021FRiallineamentoDM: TB021FRiallineamentoDM;

implementation

{$R *.dfm}

procedure TB021FRiallineamentoDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  scrPrepara.Session:=SessioneOracle;
  scrTermina.Session:=SessioneOracle;
end;

end.
