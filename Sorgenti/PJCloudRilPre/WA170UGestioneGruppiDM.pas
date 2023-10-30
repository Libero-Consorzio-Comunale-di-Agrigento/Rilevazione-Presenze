unit WA170UGestioneGruppiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR300UBaseDM, A170UGestioneGruppiMW;

type
  TWA170FGestioneGruppiDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    A170FGestioneGruppiMW: TA170FGestioneGruppiMW;
  end;

implementation

{$R *.dfm}

procedure TWA170FGestioneGruppiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  A170FGestioneGruppiMW:=TA170FGestioneGruppiMW.Create(Self);
end;

procedure TWA170FGestioneGruppiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A170FGestioneGruppiMW);
  inherited;
end;

end.
