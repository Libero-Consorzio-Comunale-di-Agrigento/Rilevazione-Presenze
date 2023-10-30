unit B002UDataStorici;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, A003UDataLavoro, Variants;

type
  TB002FDataStorici = class(TForm)
    RGStorici: TRadioGroup;
    Button1: TButton;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  B002FDataStorici: TB002FDataStorici;

function DataOut(DataIn:TDateTime; Titolo:String; AMG:Char):TDateTime;

implementation

uses B002UAggiornamento;

{$R *.DFM}

function DataOut(DataIn:TDateTime; Titolo:String; AMG:Char):TDateTime;
{Restituisce la data permettendo di specificare l'anno,il mese o i giorni
in alternativa a seconda che AMG valga A,M o G}
begin
  A003FDataLavoro:=TA003FDataLavoro.Create(Application);
  with A003FDataLavoro do
    try
      if AMG = '' then
        AMG:='G';
      Label2.Visible:=AMG in ['M','G'];
      Mese.Visible:=AMG in ['M','G'];
      Lab_Mese.Visible:=AMG in ['M','G'];
      Calendar1.Visible:=AMG = 'G';
      Caption:=Titolo;
      Data:=DataIn;
      if ShowModal = mrOk then Result:=Data
      else Result:=DataIn;
    finally
      Release;
    end;
end;

procedure TB002FDataStorici.FormCreate(Sender: TObject);
begin
  Edit1.Text:=DateToStr(Date);
end;

procedure TB002FDataStorici.Button1Click(Sender: TObject);
begin
  Edit1.Text:=DateToStr(DataOut(StrToDate(Edit1.Text),'Data di decorrenza','G'));
end;

procedure TB002FDataStorici.BitBtn1Click(Sender: TObject);
begin
  B002FAggiornamento.StoriciSuccessivi:=False;
  if RGStorici.ItemIndex > 0 then
    B002FAggiornamento.StoriciSuccessivi:=MessageDlg('Si desidera modificare anche gli eventuali movimenti storici successivi ?',
                                          mtConfirmation,[mbYes,mbNo],0) = mrYes;
end;

end.
