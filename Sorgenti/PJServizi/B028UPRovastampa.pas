unit B028UPRovastampa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, QRCtrls, ExtCtrls;

type
  TB028FProvaStampa = class(TForm)
    QuickRep1: TQuickRep;
    TitleBand1: TQRBand;
    QRLabel1: TQRLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  B028FProvaStampa: TB028FProvaStampa;

implementation

{$R *.dfm}

procedure TB028FProvaStampa.FormCreate(Sender: TObject);
begin
  QuickRep1.useQR5Justification:=True;
end;

end.
