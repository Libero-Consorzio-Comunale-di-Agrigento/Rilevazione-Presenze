unit A083UMsgElaborazioniDtm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, A000UInterfaccia, A083UMsgElaborazioni,
  A083UMsgElaborazioniMW, Oracle, L021Call;

type
  TA083FMsgElaborazioniDtm = class(TR004FGestStoricoDtM)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    A083MW: TA083FMsgElaborazioniMW;
  end;

var
  A083FMsgElaborazioniDtm: TA083FMsgElaborazioniDtm;

implementation

{$R *.dfm}

procedure TA083FMsgElaborazioniDtm.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A083MW:=TA083FMsgElaborazioniMW.Create(Self);
end;

end.
