unit A138UAreeTurni;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, StdCtrls, DBCtrls, ExtCtrls, Mask, DB, Menus, Buttons,
  ComCtrls, A000UCostanti, A000UMessaggi, A000USessione, A000UInterfaccia, C001UFiltroTabelleDtM,
  C001UFiltroTabelle, C001UScegliCampi, A002UInterfacciaSt, C005UDatiAnagrafici, C013UCheckList, C180FunzioniGenerali,
  ActnList, ImgList, ToolWin, Variants, Grids, DBGrids,
  System.Actions, System.ImageList, Oracle;

type
  TA138FAreeTurni = class(TR001FGestTab)
    grdAreeTurni: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdAreeTurniDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  LUNGHEZZA = 10;

var
  A138FAreeTurni: TA138FAreeTurni;

procedure OpenA138AreeTurni(CodArea:string);

implementation

uses A138UAreeTurniDtM;

{$R *.DFM}

procedure OpenA138AreeTurni(CodArea:string);
{Ordini Professionali}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA138AreeTurni') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A138FAreeTurni:=TA138FAreeTurni.Create(nil);
  with A138FAreeTurni do
    try
      A138FAreeTurniDtM:=TA138FAreeTurniDtM.Create(nil);
      A138FAreeTurniDtM.selT650.Locate('Codice',CodArea,[]);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A138FAreeTurniDtM.Free;
      Free;
    end;
end;

procedure TA138FAreeTurni.FormShow(Sender: TObject);
var i: Integer;
begin
  inherited;
  DButton.DataSet:=A138FAreeTurniDtM.selT650;
  // carico PickList COLORI da lista di valori costanti
  grdAreeTurni.Columns.Items[3].PickList.Clear;
  for i:=0 to High(lstColori) do
    if (lstColori[i].Sfondo = 'S') then
      grdAreeTurni.Columns.Items[3].PickList.Add(lstColori[i].Nome);
//  grdAreeTurni.Columns.Items[3].Color:=A138FAreeTurniDtM.A138MW.getColoreCellaWIN(A138FAreeTurniDtM.selT650.FieldByName('COLORE').AsString);
end;

procedure TA138FAreeTurni.grdAreeTurniDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var HoldColor: TColor;
begin
  inherited;
  HoldColor:=grdAreeTurni.Canvas.Brush.Color;
  //cambia colore della cella "COLORE"
  if Column.FieldName='COLORE' then
  begin
    grdAreeTurni.Canvas.Brush.Color:=A138FAreeTurniDtM.A138MW.getColoreCellaWIN((Sender as TDBGrid).DataSource.DataSet.FieldByName('COLORE').AsString);
    grdAreeTurni.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    grdAreeTurni.Canvas.Brush.Color:=HoldColor;
  end;
end;

procedure TA138FAreeTurni.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  SolaLettura:=SolaLetturaOriginale;
end;

end.
