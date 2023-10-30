unit A037UAnnullaScarico;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Variants;

type
  TA037FAnnullaScarico = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    chkAnnullaltimoScarico: TCheckBox;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A037FAnnullaScarico: TA037FAnnullaScarico;

implementation

uses A037UScaricoPaghe;

{$R *.DFM}

procedure TA037FAnnullaScarico.FormShow(Sender: TObject);
begin
  Label1.Caption:='E'' già stato eseguito uno scarico con Data di Scarico ' + FormatDateTime('mmmm yyyy',A037FScaricoPaghe.DataFile) + #13 +
  'E'' possibile continuare annullando le movimentazioni precedenti';
end;

end.
