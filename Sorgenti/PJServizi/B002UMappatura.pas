unit B002UMappatura;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Grids, StdCtrls, B002UAggiornamento, Variants;

type
  TB002FMappatura = class(TForm)
    MemoFile: TMemo;
    StringGrid1: TStringGrid;
    PopupMenu1: TPopupMenu;
    Aggiungicampo1: TMenuItem;
    Eliminacampo1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Aggiungicampo1Click(Sender: TObject);
    procedure Eliminacampo1Click(Sender: TObject);
    procedure StringGrid1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure StringGrid1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure MemoFileMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MemoFileEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure MemoFileDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure CercaSpazio(var Riga:Word);
  public
    { Public declarations }
  end;

var
  B002FMappatura: TB002FMappatura;

implementation

{$R *.DFM}

procedure TB002FMappatura.FormCreate(Sender: TObject);
begin
  StringGrid1.Cells[0,0]:='Nome';
  StringGrid1.Cells[1,0]:='Posizione';
  StringGrid1.Cells[2,0]:='Lunghezza';
end;

procedure TB002FMappatura.Aggiungicampo1Click(Sender: TObject);
begin
  StringGrid1.RowCount:=StringGrid1.RowCount + 1;
end;

procedure TB002FMappatura.Eliminacampo1Click(Sender: TObject);
var i,j:Word;
begin
  with StringGrid1 do
    begin
    if RowCount < 3 then exit;
    i:=Row;
    for j:=i + 1 to RowCount - 1 do
      begin
      Cells[0,j - 1]:=Cells[0,j];
      Cells[1,j - 1]:=Cells[1,j];
      Cells[2,j - 1]:=Cells[2,j];
      end;
    RowCount:=RowCount - 1;
    end;
end;

procedure TB002FMappatura.StringGrid1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
{Verifica l'accettazione della selezione}
  Accept:=MemoFile.SelLength > 0;
end;

procedure TB002FMappatura.StringGrid1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
{Trascina la parte selezionata sulla griglia}
var Riga:Word;
begin
  CercaSpazio(Riga);
  StringGrid1.Cells[1,Riga]:=IntToStr(MemoFile.SelStart + 1);
  StringGrid1.Cells[2,Riga]:=IntToStr(MemoFile.SelLength);
  MemoFile.DragMode:=dmManual;
end;

procedure TB002FMappatura.CercaSpazio(var Riga:Word);
{Cerca la prima riga vuota}
var i:Integer;
begin
  i:=StringGrid1.Cols[0].IndexOf('');
  if i = -1 then
    begin
    StringGrid1.RowCount:=StringGrid1.RowCount + 1;
    i:=StringGrid1.RowCount - 1;
    end;
  StringGrid1.Row:=i;
  Riga:=i;
end;

procedure TB002FMappatura.MemoFileMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
{Permette il drag & drop dopo la selezione di un testo}
begin
  if MemoFile.SelLength > 0 then
    MemoFile.DragMode:=dmAutomatic;
end;

procedure TB002FMappatura.MemoFileEndDrag(Sender, Target: TObject; X,
  Y: Integer);
{Ripristina la possibilità di selezionare nel memo}
begin
  MemoFile.DragMode:=dmManual;
end;

procedure TB002FMappatura.MemoFileDblClick(Sender: TObject);
var S:String;
begin
  if not Eof(FileTesto) then
    begin
    Readln(FileTesto,S);
    MemoFile.Lines.Clear;
    MemoFile.Lines.Add(S);
    end;
end;

end.
