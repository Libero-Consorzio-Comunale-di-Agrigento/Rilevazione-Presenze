unit B009UDialogBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, ExtCtrls, StdCtrls, Variants;

type
  TB009FDialogBox = class(TForm)
    LblTesto: TLabel;
    ImgErrore: TImage;
    Timer1: TTimer;
    ImgInforma: TImage;
    ImgEsclama: TImage;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    nNumSec:Real;
  public
    { Public declarations }
  end;

var
  B009FDialogBox: TB009FDialogBox;

procedure OpenB009FDialogBox(sMsg:string; sTitle:string; sTipo:string);

implementation

{$R *.DFM}

procedure OpenB009FDialogBox(sMsg:string; sTitle:string; sTipo:string);
begin
  try
    B009FDialogBox:=TB009FDialogBox.Create(nil);
    B009FDialogBox.Caption:= sTitle;
    B009FDialogBox.LblTesto.Caption:=sMsg;

    if sTipo='INFORMA' then
      B009FDialogBox.ImgInforma.Visible:=true
    else if sTipo='ESCLAMA' then
      B009FDialogBox.ImgEsclama.Visible:=true
    else
      B009FDialogBox.ImgErrore.Visible:=true;

    B009FDialogBox.ShowModal;
  finally
    B009FDialogBox.Free;
  end;
end;

procedure TB009FDialogBox.Timer1Timer(Sender: TObject);
begin
  nNumSec:=nNumSec + 1;
  if nNumSec = 10 then // dopo 3 secondi si chiude automaticamente
    B009FDialogBox.Close;
end;

procedure TB009FDialogBox.FormCreate(Sender: TObject);
begin
  nNumSec:=0;
end;

end.
