unit A158UCapitoliRimborso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R004UGestStorico, System.Actions,
  Vcl.ActnList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids,
  C180FunzioniGenerali, A000USessione, A149UCategRimborsi, A157UCapitoliTrasferte, A158UCapitoliRimborsoDM;

type
  TA158FCapitoliRimborso = class(TR004FGestStorico)
    dGrdCapitoloRimborso: TDBGrid;
    popmnuAccedi: TPopupMenu;
    Accedi1: TMenuItem;
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure popmnuAccediPopup(Sender: TObject);
    procedure Accedi1Click(Sender: TObject);
  private
    { Private declarations }
    IndCapTrasferta:integer;
    vStatoCapTrasferta:Boolean;
    procedure SetStatoTrasferta(Stato:Boolean);
    property StatoCapTrasferta:Boolean read vStatoCapTrasferta write SetStatoTrasferta;
  public
    { Public declarations }
  end;

var
  A158FCapitoliRimborso: TA158FCapitoliRimborso;

procedure OpenA158CapitoliRimborso;

implementation

{$R *.dfm}

procedure OpenA158CapitoliRimborso;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA158CapitoliRimborso') of
    'N':begin
          ShowMessage('Funzione non abilitata!');
          Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  A158FCapitoliRimborso:=TA158FCapitoliRimborso.Create(nil);
  A158FCapitoliRimborsoDM:=TA158FCapitoliRimborsoDM.Create(nil);
  try
    Screen.Cursor:=crDefault;
    A158FCapitoliRimborso.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(A158FCapitoliRimborso);
    FreeAndNil(A158FCapitoliRimborsoDM);
  end;
end;

procedure TA158FCapitoliRimborso.SetStatoTrasferta(Stato:Boolean);
begin
  vStatoCapTrasferta:=Stato;
  dGrdCapitoloRimborso.Columns[IndCapTrasferta].Field.ReadOnly:=Not vStatoCapTrasferta;
  if vStatoCapTrasferta then
  begin
    dGrdCapitoloRimborso.Columns[IndCapTrasferta].Color:=clWhite;
  end
  else
  begin
    dGrdCapitoloRimborso.Columns[IndCapTrasferta].Color:=clInactiveCaption;
  end;
end;

procedure TA158FCapitoliRimborso.Accedi1Click(Sender: TObject);
begin
  inherited;
  if dgrdCapitoloRimborso.SelectedField.FieldName.ToUpper = 'DCATEG_RIMBORSO' then
  begin
    OpenA149CategRimborsi(dgrdCapitoloRimborso.SelectedField.Asstring);
    A158FCapitoliRimborsoDM.A158MW.selM022.Refresh;
  end
  else if dgrdCapitoloRimborso.SelectedField.FieldName.ToUpper = 'CAPITOLO_TRASFERTA' then
  begin
    OpenA157CapitoliTrasferta(dgrdCapitoloRimborso.SelectedField.Asstring);
    A158FCapitoliRimborsoDM.A158MW.selM030.Refresh;
  end
end;

procedure TA158FCapitoliRimborso.DButtonDataChange(Sender: TObject; Field: TField);
var
  i:integer;
begin
  inherited;
  if (Field <> nil) and (Field.FieldName = 'DECORRENZA') then
  begin
    A158FCapitoliRimborsoDM.A158MW.ElencoCapitoliTrasferta(Field.AsDateTime);
    StatoCapTrasferta:=Length(A158FCapitoliRimborsoDM.A158MW.ArrCapitoliTrasferta) > 0;
    dGrdCapitoloRimborso.Repaint;
    dGrdCapitoloRimborso.Columns[IndCapTrasferta].PickList.Clear;
    for i:=Low(A158FCapitoliRimborsoDM.A158MW.ArrCapitoliTrasferta) to High(A158FCapitoliRimborsoDM.A158MW.ArrCapitoliTrasferta) do
      dGrdCapitoloRimborso.Columns[IndCapTrasferta].PickList.Add(A158FCapitoliRimborsoDM.A158MW.ArrCapitoliTrasferta[i].Value);
  end;
end;

procedure TA158FCapitoliRimborso.FormShow(Sender: TObject);
begin
  inherited;
  IndCapTrasferta:=R180GetColonnaDBGrid(dGrdCapitoloRimborso,'CAPITOLO_TRASFERTA');
end;

procedure TA158FCapitoliRimborso.popmnuAccediPopup(Sender: TObject);
begin
  inherited;
  Accedi1.Visible:=R180In(dgrdCapitoloRimborso.SelectedField.FieldName.ToUpper,['DCATEG_RIMBORSO','CAPITOLO_TRASFERTA']);
end;

end.
