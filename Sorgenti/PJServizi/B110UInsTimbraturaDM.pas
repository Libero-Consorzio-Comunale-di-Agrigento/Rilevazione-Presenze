unit B110UInsTimbraturaDM;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  A000USessione,
  A023UTimbratureMW,
  B110USharedTypes,
  B110UUtils,
  C200UWebServicesTypes,
  FunzioniGenerali,
  R015UDatasnapRestDM,
  W000UMessaggi,
  System.SysUtils,
  System.Classes,
  Data.DB,
  OracleData;

type
  TB110FInsTimbraturaDM = class(TR015FDatasnapRestDM)
    selVT100: TOracleDataSet;
  private
    FDatiTimbratura: TDatiTimbratura;
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  public
    property DatiTimbratura: TDatiTimbratura read FDatiTimbratura write FDatiTimbratura;
  end;

implementation

{$R *.dfm}

{ TB110FInsTimbraturaDM }

function TB110FInsTimbraturaDM.ControlloParametri: TResCtrl;
begin
  //Result.Ok:=False;
  Result.Messaggio:='';

  //...

  // controlli ok
  Result.Ok:=True;
end;

procedure TB110FInsTimbraturaDM.Esegui(var RRisultato: TRisultato);
var
  A023MW: TA023FTimbratureMW;
  LRes: TOutputInsTimbratura;
begin
  try
    A023MW:=TA023FTimbratureMW.Create(Owner);
    A023MW.CtrlRegistraTimbratura(FDatiTimbratura);

    // prepara risultato servizio
    RRisultato.Output:=TOutputInsTimbratura.Create;
    LRes:=TOutputInsTimbratura(RRisultato.Output);
    LRes.RisposteMsg.Assign(FDatiTimbratura.RisposteMsg);
  finally
    FreeAndNil(A023MW);
  end;
end;

end.
