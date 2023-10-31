unit A149UCategRimborsi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R001UGESTTAB, System.Actions,
  Vcl.ActnList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids, Vcl.DBGrids,
  OracleData, A000USessione;

type
  TA149FCategRimborsi = class(TR001FGestTab)
    dgrdCategRimborsi: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A149FCategRimborsi: TA149FCategRimborsi;

procedure OpenA149CategRimborsi(Cod:String = '');

implementation

uses
  A149UCategRimborsiDM;

{$R *.dfm}

procedure OpenA149CategRimborsi(Cod:String = '');
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA149CategRimborsi') of
    'N':begin
          ShowMessage('Funzione non abilitata!');
          Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  A149FCategRimborsiDM:=TA149FCategRimborsiDM.Create(nil);
  A149FCategRimborsi:=TA149FCategRimborsi.Create(nil);
  A149FCategRimborsiDM.selM022.SearchRecord('CODICE',Cod,[srFromBeginning]);
  Screen.Cursor:=crDefault;
  try
    A149FCategRimborsi.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(A149FCategRimborsi);
    FreeAndNil(A149FCategRimborsiDM);
  end;
end;

end.
