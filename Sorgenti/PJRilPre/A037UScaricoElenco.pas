unit A037UScaricoElenco;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, checklst, Buttons, ExtCtrls, Variants;

type
  TA033FElenco = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Anomalie1: TCheckListBox;
    Anomalie2: TCheckListBox;
    Anomalie3: TCheckListBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A033FElenco: TA033FElenco;

implementation

{$R *.DFM}

procedure TA033FElenco.FormCreate(Sender: TObject);
begin
  Anomalie1.Align:=alClient;
  Anomalie2.Align:=alClient;
  Anomalie3.Align:=alClient;
end;

end.
