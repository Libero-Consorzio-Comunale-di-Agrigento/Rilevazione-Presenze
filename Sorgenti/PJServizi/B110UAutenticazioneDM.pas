unit B110UAutenticazioneDM;

interface

uses
  A000UCostanti,
  R015UDatasnapRestDM,
  C200UWebServicesTypes,
  System.SysUtils,
  System.Classes;

type
  TB110FAutenticazioneDM = class(TR015FDatasnapRestDM)
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  end;

implementation

{$R *.dfm}

function TB110FAutenticazioneDM.ControlloParametri: TResCtrl;
begin
  Result.Ok:=True;
  Result.Messaggio:='';
end;

procedure TB110FAutenticazioneDM.Esegui(var RRisultato: TRisultato);
begin
  // l'autenticazione viene effettuata dal datamodule padre R015
  // se l'esecuzione arriva fin qui significa che l'autenticazione è ok
  RRisultato.AddInfo('Autenticazione ok');
end;

end.
