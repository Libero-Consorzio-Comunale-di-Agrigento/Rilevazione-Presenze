unit A003UDataLavoro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Calendar, StdCtrls, Spin, Buttons, ExtCtrls, C180FunzioniGenerali, Variants;

type
  TA003FDataLavoro = class(TForm)
    Calendar1: TCalendar;
    Panel1: TPanel;
    Label1: TLabel;
    Anno: TSpinEdit;
    Label2: TLabel;
    Mese: TSpinEdit;
    Lab_Mese: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure AnnoChange(Sender: TObject);
    procedure MeseChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A003FDataLavoro: TA003FDataLavoro;
  Data:TDateTime;

function DataOut(DataIn:TDateTime; Titolo:String; AMG:Char):TDateTime;

implementation

{$R *.DFM}

type tMesi = Array[1..12] of String;
const Mesi:tMesi = ('Gennaio','Febbraio','Marzo','Aprile','Maggio','Giugno','Luglio','Agosto',
'Settembre','Ottobre','Novembre','Dicembre');

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

procedure TA003FDataLavoro.AnnoChange(Sender: TObject);
begin
  Calendar1.Year:=Anno.Value;
end;

procedure TA003FDataLavoro.MeseChange(Sender: TObject);
begin
  with Calendar1 do
    if Day > R180GiorniMese(EncodeDate(Year,Mese.Value,1)) then
      Day:=R180GiorniMese(EncodeDate(Year,Mese.Value,1));
   calendar1.Month:=Mese.Value;
   Lab_Mese.Caption:=Mesi[Mese.Value];
end;

procedure TA003FDataLavoro.FormActivate(Sender: TObject);
begin
  Calendar1.Day:=1;
  Calendar1.Year:=StrToInt(FormatDateTime('yyyy',Data));
  if Mese.Visible then
    Calendar1.Month:=StrToInt(FormatDateTime('mm',Data))
  else
    Calendar1.Month:=1;
  if Calendar1.Visible then
    Calendar1.Day:=StrToInt(FormatDateTime('dd',Data));
  Anno.Value:=Calendar1.Year;
  Mese.Value:=Calendar1.Month;
end;

procedure TA003FDataLavoro.BitBtn1Click(Sender: TObject);
begin
   Data:=Calendar1.CalendarDate;
end;

end.
