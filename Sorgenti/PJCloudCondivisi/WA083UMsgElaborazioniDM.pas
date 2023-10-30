unit WA083UMsgElaborazioniDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle, A000UCostanti, A000USessione, L021Call, A083UMsgElaborazioniMW,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient, C180FunzioniGenerali;

type
  TWA083FMsgElaborazioniDM = class(TWR302FGestTabellaDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
  private
  public
    A083MW: TA083FMsgElaborazioniMW;
  end;

implementation

{$R *.dfm}

procedure TWA083FMsgElaborazioniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  A083MW:=TA083FMsgElaborazioniMW.Create(Self);
end;

end.
