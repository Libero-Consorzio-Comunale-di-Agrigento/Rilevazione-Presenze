unit W002USQL;
{PUBDIST}

interface

uses
  Classes, Controls, IWCompMemo, IWControl, IWCompButton,IWForm, IWAppForm, Variants,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl;

type
  TW002FSQL = class(TIWAppForm)
    btnOK: TIWButton;
    memoSQL: TIWMemo;
    procedure btnOKClick(Sender: TObject);
  public
  end;

implementation
{$R *.dfm}

procedure TW002FSQL.btnOKClick(Sender: TObject);
begin
  Release;
end;

end.
