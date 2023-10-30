unit P554UElaborazioneContoAnnualeDtM;

interface

uses
  P554UElaborazioneContoAnnualeMW,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R004UGESTSTORICODTM, Db, OracleData,  C700USelezioneAnagrafe, A000UCostanti,
  A000USessione, A000UInterfaccia, Variants, Oracle;


type
  TP554FElaborazioneContoAnnualeDtM = class(TR004FGestStoricoDtM)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    P554MW: TP554FElaborazioneContoAnnualeMW;
  end;

var
  P554FElaborazioneContoAnnualeDtM: TP554FElaborazioneContoAnnualeDtM;

implementation

{$R *.DFM}

procedure TP554FElaborazioneContoAnnualeDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  P554MW:=TP554FElaborazioneContoAnnualeMW.Create(Self);
end;

procedure TP554FElaborazioneContoAnnualeDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(P554MW);
  inherited;
end;

end.
