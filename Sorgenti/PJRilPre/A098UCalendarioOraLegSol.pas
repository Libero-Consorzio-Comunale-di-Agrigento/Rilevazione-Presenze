unit A098UCalendarioOraLegSol;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, Actions, ActnList, ImgList, Data.DB, Menus, ComCtrls,
  ToolWin, Grids, DBGrids, A098UCalendarioOraLegSolDtm, A000USessione;

type
  TA098FCalendarioOraLegSol = class(TR001FGestTab)
    dGrdT110: TDBGrid;
    procedure Stampa1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A098FCalendarioOraLegSol: TA098FCalendarioOraLegSol;

procedure OpenA098CalendarioOraLegSol;

implementation

{$R *.dfm}

procedure OpenA098CalendarioOraLegSol;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA098CalendarioOraLegSol') of
    'N':begin
          ShowMessage('Funzione non abilitata!');
          Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A098FCalendarioOraLegSol:=TA098FCalendarioOraLegSol.Create(nil);
  try
    A098FCalendarioOraLegSolDtm:=TA098FCalendarioOraLegSolDtm.Create(nil);
    A098FCalendarioOraLegSol.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(A098FCalendarioOraLegSolDtm);
    FreeAndNil(A098FCalendarioOraLegSol);
  end;
end;


procedure TA098FCalendarioOraLegSol.Stampa1Click(Sender: TObject);
begin
  QueryStampa.Clear;
  QueryStampa.Add('SELECT T110.* FROM T110_ORALEGALESOLARE T110');
  NomiCampiR001.Clear;
  NomiCampiR001.Add('T110.DATA');
  NomiCampiR001.Add('T110.ORAVECCHIA');
  NomiCampiR001.Add('T110.ORANUOVA');
  NomiCampiR001.Add('T110.VERSO');
  inherited;
end;

end.
