unit A208UVisualizzazioneFileInfoEsterne;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls,Printers, Variants;

type
  TA208FVisualizzazioneFileInfoEsterne = class(TForm)
    memVisualizzaFileInfoEsterne: TMemo;
    Panel1: TPanel;
    btnChiudi: TBitBtn;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    NomeFile: String;
  public
    { Public declarations }
    procedure SetNomeFile(const FileName : String);
  end;

var
  A208FVisualizzazioneFileInfoEsterne: TA208FVisualizzazioneFileInfoEsterne;

implementation

{$R *.DFM}

procedure TA208FVisualizzazioneFileInfoEsterne.SetNomeFile(const FileName : String);
begin
  NomeFile:=FileName;
end;

procedure TA208FVisualizzazioneFileInfoEsterne.FormActivate(Sender: TObject);
begin
  memVisualizzaFileInfoEsterne.Lines.Clear;
  if NomeFile <> '' then
    memVisualizzaFileInfoEsterne.Lines.LoadFromFile(NomeFile);
end;

end.
