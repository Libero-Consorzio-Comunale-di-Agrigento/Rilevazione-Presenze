unit A156UNotificheIrisWEB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, A000USessione,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R001UGESTTAB, System.Actions,
  Vcl.ActnList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, System.ImageList;

type
  TA156FNotificheIrisWEB = class(TR001FGestTab)
    dgrdNotifiche: TDBGrid;
    pnlBottom: TPanel;
    dmemNotificaSqlText: TDBMemo;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A156FNotificheIrisWEB: TA156FNotificheIrisWEB;

procedure OpenA156NotificheIrisWEB;

implementation

uses A156UNotificheIrisWEBDtM;

{$R *.dfm}

procedure OpenA156NotificheIrisWEB;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA156NotificheIrisWEB') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  A156FNotificheIrisWEB:=TA156FNotificheIrisWEB.Create(nil);
  A156FNotificheIrisWEBDtM:=TA156FNotificheIrisWEBDtM.Create(nil);
  try
    Screen.Cursor:=crDefault;
    A156FNotificheIrisWEB.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A156FNotificheIrisWEB.Free;
    A156FNotificheIrisWEBDtM.Free;
  end;
end;

procedure TA156FNotificheIrisWEB.FormCreate(Sender: TObject);
begin
  inherited;
  //
end;

procedure TA156FNotificheIrisWEB.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A156FNotificheIrisWEBDtM.selI040;
end;

end.
