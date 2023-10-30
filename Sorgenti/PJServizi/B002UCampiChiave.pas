unit B002UCampiChiave;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Variants;

type
  TB002FCampiChiave = class(TForm)
    ListBox5: TListBox;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    procedure ListBox2DblClick(Sender: TObject);
    procedure ListBox5DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListBox5DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListBox5DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  B002FCampiChiave: TB002FCampiChiave;

implementation

uses B002UAggiornamento;

{$R *.DFM}

procedure TB002FCampiChiave.ListBox2DblClick(Sender: TObject);
begin
  ListBox2.Items.Clear;
  with B002FAggiornamento do
    begin
    KeyDest.Clear;
    KeySorg.Clear;
    end;
end;

procedure TB002FCampiChiave.ListBox5DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=(ListBox1.ItemIndex > -1) and (ListBox5.ItemIndex > -1);
  if not Accept then exit;
  Accept:=B002FAggiornamento.KeySorg.IndexOf(ListBox1.Items[ListBox1.ItemIndex]) = -1;
  if not Accept then exit;
  Accept:=B002FAggiornamento.KeyDest.IndexOf(ListBox5.Items[ListBox5.ItemIndex]) = -1;
end;

procedure TB002FCampiChiave.ListBox5DragDrop(Sender, Source: TObject; X,
  Y: Integer);
{Impostazione di un link fra le due tabelle col drag & drop}
begin
  ListBox2.Items.Add(ListBox1.Items[ListBox1.ItemIndex] + ' <----> ' + ListBox5.Items[ListBox5.ItemIndex]);
  B002FAggiornamento.KeySorg.Add(ListBox1.Items[ListBox1.ItemIndex]);
  B002FAggiornamento.KeyDest.Add(ListBox5.Items[ListBox5.ItemIndex]);
end;

procedure TB002FCampiChiave.ListBox5DblClick(Sender: TObject);
{Impostazione di un link fra le due tabelle col doppio click}
begin
  if (ListBox1.ItemIndex > -1) and (LIstBox5.ItemIndex > -1) then
    if (B002FAggiornamento.KeySorg.IndexOf(ListBox1.Items[ListBox1.ItemIndex]) = -1) and
       (B002FAggiornamento.KeyDest.IndexOf(ListBox5.Items[ListBox5.ItemIndex]) = -1) then
      ListBox5DragDrop(ListBox5,ListBox1,0,0);
end;

end.
