unit P686UCalcoloFondiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, Oracle, DB, OracleData,
  C180FunzioniGenerali, P686UCalcoloFondiMW;

type
  TP686FCalcoloFondiDtM = class(TR004FGestStoricoDtM)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure evtRichiesta(Msg,Chiave:String);
  public
    { Public declarations }
    P686FCalcoloFondiMW: TP686FCalcoloFondiMW;
  end;

var
  P686FCalcoloFondiDtM: TP686FCalcoloFondiDtM;

implementation

uses P686UCalcoloFondi;

{$R *.dfm}

procedure TP686FCalcoloFondiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  P686FCalcoloFondiMW:=TP686FCalcoloFondiMW.Create(Self);
  P686FCalcoloFondiMW.evtRichiesta:=evtRichiesta;
  P686FCalcoloFondiMW.evtAvanzaProgressBar:=P686FCalcoloFondi.AvanzaProgressBar;
end;

procedure TP686FCalcoloFondiDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(P686FCalcoloFondiMW);
  inherited;
end;

procedure TP686FCalcoloFondiDtM.evtRichiesta(Msg,Chiave:String);
begin
  if R180MessageBox(Msg,'DOMANDA') <> mrYes then
    Abort;
end;

end.
